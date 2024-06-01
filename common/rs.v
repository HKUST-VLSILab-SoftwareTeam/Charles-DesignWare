/*
# Register Slice Module in Verilog

The Register Slice (RS) module is a parameterized Verilog module that provides different handshake mechanisms 
for data transfer. It can be configured for forward buffered handshake, backward buffered handshake, 
or bidirectional buffered handshake. This module can be used in various applications such as dataflow processing, 
communication interfaces, and buffering between different clock domains.

## Functionality

The Register Slice module has three primary functions:

1. **Forward Buffered Handshake**: In this mode, the module buffers the incoming data and provides a ready 
signal to the data source. The data is forwarded to the next stage when the next stage provides a ready signal.

2. **Backward Buffered Handshake**: In this mode, the module buffers the incoming data and provides a valid 
signal to the next stage. The data is forwarded to the next stage when the data source provides a ready signal.

3. **Bidirectional Buffered Handshake**: In this mode, the module buffers the incoming data and provides both 
a ready signal to the data source and a valid signal to the next stage. The data is forwarded to the next stage 
when both the data source and the next stage provide ready signals.

## Usage

To use the Register Slice module, include the module in your Verilog project and instantiate it with the desired 
mode of operation. The parameters `FORWARD`, `BACKWARD`, and `BIDIRECTION` are used to configure the module 
for the desired mode.

For example, to instantiate a Register Slice with forward buffered handshake mode, use the following code:

```verilog
register_slice #(
    .FORWARD(1'b1),
    .BACKWARD(1'b0),
    .BIDIRECTION(1'b0)
) my_register_slice (
    .clk(clk),
    .rst_n(rst_n),
    .i_valid(i_valid),
    .o_valid(o_valid),
    .i_ready(i_ready),
    .o_ready(o_ready),
    .i_data(i_data),
    .o_data(o_data)
);
```

## Inputs and Outputs

The Register Slice module has the following inputs and outputs:

- `clk`:        The clock input signal. The module operates on the rising edge of the clock signal.
- `rst_n`:      The reset input signal (active low). When this signal is low, the module resets its 
                internal state and outputs.
- `i_valid`:    The valid input signal. This signal indicates that valid data is present on the `i_data` input.
- `o_valid`:    The valid output signal. This signal indicates that valid data is present on the `o_data` output 
                and is ready to be consumed by the next stage.
- `i_ready`:    The ready input signal. This signal indicates that the next stage is ready to accept the data 
                on the `o_data` output.
- `o_ready`:    The ready output signal. This signal indicates that the module is ready to accept new data on 
                the `i_data` input.
- `i_data`:     The data input signal (32-bit wide). This signal carries the input data to the module.
- `o_data`:     The data output signal (32-bit wide). This signal carries the output data from the module to 
                the next stage.

The handshake mechanism is controlled by the `i_valid`, `o_valid`, `i_ready`, and `o_ready` signals. 
Depending on the selected mode, the module will provide ready and/or valid signals to the data source and the 
next stage, enabling smooth data transfer between different stages in the system.
*/

module RS
#(
    parameter FORWARD       = 1'b0,
    parameter BACKWARD      = 1'b0,
    parameter BIDIRECTION   = 1'b0
)
(
    input wire          clk,
    input wire          rst_n,

    input wire          i_valid,
    output reg          o_valid,
    input wire          i_ready,
    output reg          o_ready,

    input wire [31:0]   i_data,
    output reg [31:0]   o_data
);

    // Forward buffered handshake
    reg forward_valid, forward_ready;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            forward_valid <= 1'b0;
        end else begin
            forward_valid <= i_valid;
        end
    end

    assign forward_ready = !o_valid || i_ready;

    // Backward buffered handshake
    reg backward_valid, backward_ready;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            backward_ready <= 1'b1;
        end else begin
            backward_ready <= !i_valid || o_ready;
        end
    end

    assign backward_valid = o_valid;

    // Bidirectional buffered handshake
    reg bidir_valid, bidir_ready;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            bidir_valid <= 1'b0;
            bidir_ready <= 1'b1;
        end else begin
            bidir_valid <= i_valid && i_ready;
            bidir_ready <= !o_valid || o_ready;
        end
    end

    // Output assignments
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            o_valid <= 1'b0;
            o_ready <= 1'b1;
            o_data <= 32'b0;
        end else begin
            if (FORWARD) begin
                o_valid <= forward_valid;
                o_ready <= forward_ready;
            end else if (BACKWARD) begin
                o_valid <= backward_valid;
                o_ready <= backward_ready;
            end else if (BIDIRECTION) begin
                o_valid <= bidir_valid;
                o_ready <= bidir_ready;
            end

            if (i_valid && i_ready) begin
                o_data <= i_data;
            end
        end
    end

endmodule