PIC_LD=ld
LDVERSION= $(shell $(PIC_LD) -v | grep -q 2.30 ;echo $$?)
ifeq ($(LDVERSION), 0)
     LD_NORELAX_FLAG= --no-relax
endif

ARCHIVE_OBJS=
ARCHIVE_OBJS += _37807_archive_1.so
_37807_archive_1.so : archive.0/_37807_archive_1.a
	@$(AR) -s $<
	@$(PIC_LD) -shared  -Bsymbolic $(LD_NORELAX_FLAG)  -o .//../simv.daidir//_37807_archive_1.so --whole-archive $< --no-whole-archive
	@rm -f $@
	@ln -sf .//../simv.daidir//_37807_archive_1.so $@


ARCHIVE_OBJS += _37836_archive_1.so
_37836_archive_1.so : archive.0/_37836_archive_1.a
	@$(AR) -s $<
	@$(PIC_LD) -shared  -Bsymbolic $(LD_NORELAX_FLAG)  -o .//../simv.daidir//_37836_archive_1.so --whole-archive $< --no-whole-archive
	@rm -f $@
	@ln -sf .//../simv.daidir//_37836_archive_1.so $@


ARCHIVE_OBJS += _37837_archive_1.so
_37837_archive_1.so : archive.0/_37837_archive_1.a
	@$(AR) -s $<
	@$(PIC_LD) -shared  -Bsymbolic $(LD_NORELAX_FLAG)  -o .//../simv.daidir//_37837_archive_1.so --whole-archive $< --no-whole-archive
	@rm -f $@
	@ln -sf .//../simv.daidir//_37837_archive_1.so $@


ARCHIVE_OBJS += _37838_archive_1.so
_37838_archive_1.so : archive.0/_37838_archive_1.a
	@$(AR) -s $<
	@$(PIC_LD) -shared  -Bsymbolic $(LD_NORELAX_FLAG)  -o .//../simv.daidir//_37838_archive_1.so --whole-archive $< --no-whole-archive
	@rm -f $@
	@ln -sf .//../simv.daidir//_37838_archive_1.so $@


ARCHIVE_OBJS += _37839_archive_1.so
_37839_archive_1.so : archive.0/_37839_archive_1.a
	@$(AR) -s $<
	@$(PIC_LD) -shared  -Bsymbolic $(LD_NORELAX_FLAG)  -o .//../simv.daidir//_37839_archive_1.so --whole-archive $< --no-whole-archive
	@rm -f $@
	@ln -sf .//../simv.daidir//_37839_archive_1.so $@


ARCHIVE_OBJS += _37840_archive_1.so
_37840_archive_1.so : archive.0/_37840_archive_1.a
	@$(AR) -s $<
	@$(PIC_LD) -shared  -Bsymbolic $(LD_NORELAX_FLAG)  -o .//../simv.daidir//_37840_archive_1.so --whole-archive $< --no-whole-archive
	@rm -f $@
	@ln -sf .//../simv.daidir//_37840_archive_1.so $@





O0_OBJS =

$(O0_OBJS) : %.o: %.c
	$(CC_CG) $(CFLAGS_O0) -c -o $@ $<


%.o: %.c
	$(CC_CG) $(CFLAGS_CG) -c -o $@ $<
CU_UDP_OBJS = \


CU_LVL_OBJS = \
SIM_l.o 

MAIN_OBJS = \
objs/amcQw_d.o 

CU_OBJS = $(MAIN_OBJS) $(ARCHIVE_OBJS) $(CU_UDP_OBJS) $(CU_LVL_OBJS)

