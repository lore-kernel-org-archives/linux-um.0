Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ChXlE-0006Si-0g for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Dec 2004 10:32:28 -0800
Received: from rimuhosting.com ([69.90.33.248])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1ChXl8-00071Y-SM
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 23 Dec 2004 10:32:27 -0800
Message-ID: <41CB7FBB.10705@rimuhosting.com>
From: Peter <peter.spamcatcher@rimuhosting.com>
MIME-Version: 1.0
Subject: Re: [Fwd: Re: [uml-devel] Memory corruption/errors?]
References: <41CAC781.1030903@fujitsu-siemens.com>
In-Reply-To: <41CAC781.1030903@fujitsu-siemens.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 24 Dec 2004 15:32:27 +1300
To: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux devel <user-mode-linux-devel@lists.sourceforge.net>

Hi.  Thanks for the patch.

I am trying to apply these against 2.6.9 + bb4 (from 
http://www.user-mode-linux.org/~blaisorblade/patches/guest/uml-2.6.9-bb4/). 
   Your patch is not applying (no such file, HUNKs failing, etc).

Do you have a version of your patch that compiles against 2.6.9-bb4? 
Ideally I'd like to get this working with 2.6.9-bb4 since that seems to 
be the 'stable' 2.6 UML guest kernel.

Else, can you let me know what code (links to all component patches 
appreciated) your patch is against and I will try that.

Regards, Peter

Bodo Stroesser wrote:
> I'm forwarding this to the list, because I did a "Reply to all"
> missing the fact, that the list wasn't CC'ed
> 
> Bodo
> 
> ------------------------------------------------------------------------
> 
> Subject:
> Re: [uml-devel] Memory corruption/errors?
> From:
> Bodo Stroesser <bstroesser@fujitsu-siemens.com>
> Date:
> Thu, 23 Dec 2004 13:58:18 +0100
> To:
> Peter <peter.spamcatcher@rimuhosting.com>
> 
> To:
> Peter <peter.spamcatcher@rimuhosting.com>
> CC:
> Jeff Dike <jdike@addtoit.com>
> 
> 
> Peter wrote:
> 
>>
>> I really don't know what fxsr is.  But I think I have it.  My servers 
>> are dual proc xeons.  2.6.8.1 with skas3 v7 (mostly).
>>
>> # cat /proc/cpuinfo  | grep fxsr
>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
>> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
>> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
>> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
>> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
>> mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe cid
> 
> Yes. Here the machine tell us, that fxsr is available.
> 
>>
>> So you can only reproduce the problem when your use the sighandler?  
>> But when you use your patch the problem is not triggered (even with 
>> the sighandler)?
>>
>> I'd be happy to try a patch.  I only have production machines at the 
>> moment, so I may not be able to restart one for a week or two until 
>> some new ones arrive.
>>
>> Regards, Peter
>>
>> Bodo Stroesser wrote:
>>
>>> Peter wrote:
>>>
>>>> I don't run TT mode UMLs.  So, no I haven't tried that.
>>>>
>>>> I don't know about the sighandler.  The program runs as it was 
>>>> listed. It is running on a 'regular' server (Debian, and/or WBL3) 
>>>> with other processes running.  And the host servers happen to be 
>>>> running other UMLs.  I don't know if that information helps.  (i.e. 
>>>> can a sighandler in another process on the UML or on the host cause 
>>>> this problem?)
>>>>
>>>> I'd be happy to try out a skas patch - preferably if it just applied 
>>>> to the guest ;)  To see if it fixes things or not.
>>>>
>>>> Regards, Peter
>>>>
>>> I could try to create a patch, just for testing.
>>> What machine is your host? It probably has fxsr?
>>>
>>> Bodo
> 
> OK. Here it is! For testing only!
> 
> I've tested the patch on a XEON 2.4GHz, and AFAICS it works.
> But no guarantee!
> 
> The errors with memtest2 no longer occur on my system.
> 
> I have no machine without fxsr, thus I couldn't test that.
> When the patch is applied, don't forget to do
>     "make clean ARCH=um"
> before recompiling the kernel.Else you will get an
> inconsitent kernel that crashes.
> 
> Bodo
> 
> 
> ------------------------------------------------------------------------
> 
> From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
> 
> This patch is for testing only!
> 
> It's a quick and dirty patch to verify, that wrong fp-context
> saving and restore really are the cause of errors in "memtest.c"
> It fixes the problem by:
>  - making have_fpx_regs accessible for other modules instead of
>    declaring it "static" in arch/um/os-Linux/sys-i386/registers.c
>  - Adding 1 to HOST_FP_SIZE to have room for the "status" (and magic)
>    field. Now skas.fp + skas.xfp combined have the size of
>    struct _fpstatus
>  - in arch/um/sys-i386/signal.c adding some code, that handles
>    the _fpstatus in sigcontext differently, depending on have_fpx_regs.
>    For (have_fpx_regs == 0), the _fpstatus simply is copied to/from
>    user from/to skas.fp. When writing to user, the status field is
>    created also.
>    For (have_fpx_regs == 1), when writing to user, the full _fpstatus
>    is created in skas.fp and skas.xfp, from the data found in skas.xfp.
>    Then it is copied to user. When reading, the full _fpstatus is read
>    to skas.fp and skas.xfp. Then, skas.xfp is reconstructed from this
>    data.
> 
> ---
> 
> --- arch/um/os-Linux/sys-i386/registers.c.orig	2004-12-23 00:22:54.000000000 +0100
> +++ arch/um/os-Linux/sys-i386/registers.c	2004-12-23 00:23:13.016000444 +0100
> @@ -17,7 +17,7 @@
>  static unsigned long exec_regs[HOST_FRAME_SIZE];
>  static unsigned long exec_fp_regs[HOST_FP_SIZE];
>  static unsigned long exec_fpx_regs[HOST_XFP_SIZE];
> -static int have_fpx_regs = 1;
> +int have_fpx_regs = 1;
>  
>  void init_thread_registers(union uml_pt_regs *to)
>  {
> --- arch/um/sys-i386/signal.c.orig	2004-12-23 00:17:19.000000000 +0100
> +++ arch/um/sys-i386/signal.c	2004-12-23 11:41:41.928379633 +0100
> @@ -19,15 +19,37 @@
>  
>  #include "skas.h"
>  
> +
> +static inline unsigned short twd_i387_to_fxsr( unsigned short twd )
> +{
> +    unsigned int tmp; /* to avoid 16 bit prefixes in the code */
> +
> +    /* Transform each pair of bits into 01 (valid) or 00 (empty) */
> +    tmp = ~twd;
> +    tmp = (tmp | (tmp>>1)) & 0x5555; /* 0V0V0V0V0V0V0V0V */
> +    /* and move the valid bits to the lower byte. */
> +    tmp = (tmp | (tmp >> 1)) & 0x3333; /* 00VV00VV00VV00VV */
> +    tmp = (tmp | (tmp >> 2)) & 0x0f0f; /* 0000VVVV0000VVVV */
> +    tmp = (tmp | (tmp >> 4)) & 0x00ff; /* 00000000VVVVVVVV */
> +    return tmp;
> +}
> +
> +#define printk printf
> +
>  static int copy_sc_from_user_skas(struct pt_regs *regs,
>  				  struct sigcontext *from)
>  {
>    	struct sigcontext sc;
> -	unsigned long fpregs[HOST_FP_SIZE];
> -	int err;
> +	struct _fpstate * fp = (struct _fpstate *)regs->regs.skas.fp;
> +	int size, err, i;
> +
> +	if (have_fpx_regs)
> +		size = sizeof(struct _fpstate);
> +	else
> +		size = sizeof(regs->regs.skas.fp);
>  
>  	err = copy_from_user(&sc, from, sizeof(sc));
> -	err |= copy_from_user(fpregs, sc.fpstate, sizeof(fpregs));
> +	err |= copy_from_user(fp, sc.fpstate, size);
>  	if(err)
>  		return(err);
>  
> @@ -48,23 +70,70 @@
>  	REGS_EFLAGS(regs->regs.skas.regs) = sc.eflags;
>  	REGS_SS(regs->regs.skas.regs) = sc.ss;
>  
> -	err = ptrace_setfpregs(userspace_pid[0], fpregs);
> -	if(err < 0){
> -	  	printk("copy_sc_from_user_skas - PTRACE_SETFPREGS failed, "
> -		       "errno = %d\n", err);
> -		return(1);
> +	if (have_fpx_regs) {
> +	    *(unsigned short *)fp->_fxsr_env = (unsigned short)(fp->cw & 0xffff);
> +	    *((unsigned short *)fp->_fxsr_env + 1) = (unsigned short)(fp->sw & 0xffff);
> +	    *((unsigned short *)fp->_fxsr_env + 2) = twd_i387_to_fxsr(fp->tag & 0xffff);
> +	    *((unsigned short *)fp->_fxsr_env + 3) = (unsigned short)(fp->cssel >> 16);
> +	    fp->_fxsr_env[2] = fp->ipoff;
> +	    fp->_fxsr_env[3] = fp->cssel & 0xffff;
> +	    fp->_fxsr_env[4] = fp->dataoff;
> +	    fp->_fxsr_env[5] = fp->datasel;
> +	    for ( i=0; i<8; i++)
> +		memcpy(fp->_fxsr_st+i, fp->_st+i, sizeof(struct _fpreg));
>  	}
>  
>  	return(0);
>  }
>  
> +static inline unsigned long twd_fxsr_to_i387( struct _fpstate *fp)
> +{
> +    struct _fpxreg *st = fp->_fxsr_st;
> +    unsigned long twd = fp->_fxsr_env[1] & 0x0000fffflu;
> +    unsigned long tag;
> +    unsigned long ret = 0xffff0000lu;
> +    int i;
> +
> +    for ( i = 0 ; i < 8 ; i++, st++ ) {
> +	if ( twd & 0x1 ) {
> +	    switch ( st->exponent & 0x7fff ) {
> +		case 0x7fff:
> +		    tag = 2;
> +		    break;
> +		case 0x0000:
> +		    if ( !st->significand[0] &&
> +		         !st->significand[1] &&
> +		         !st->significand[2] &&
> +		         !st->significand[3] ) {
> +			tag = 1;
> +		    } else {
> +			tag = 2;
> +		    }
> +		    break;
> +		default:
> +		    if ( st->significand[3] & 0x8000 ) {
> +			tag = 0;
> +		    } else {
> +			tag = 2;
> +		    }
> +		    break;
> +	    }
> +	} else {
> +	    tag = 3;
> +	}
> +	ret |= (tag << (2 * i));
> +	twd = twd >> 1;
> +    }
> +    return ret;
> +}
> +
>  int copy_sc_to_user_skas(struct sigcontext *to, struct _fpstate *to_fp,
>  			 struct pt_regs *regs)
>  {
>    	struct sigcontext sc;
> -	unsigned long fpregs[HOST_FP_SIZE];
> +	struct _fpstate * fp = (struct _fpstate *)regs->regs.skas.fp;
>  	struct faultinfo * fi = &current->thread.arch.faultinfo;
> -	int err;
> +	int size, i;
>  
>  	sc.gs = REGS_GS(regs->regs.skas.regs);
>  	sc.fs = REGS_FS(regs->regs.skas.regs);
> @@ -87,20 +156,30 @@
>  	sc.err = fi->error_code;
>  	sc.trapno = fi->trap_no;
>  
> -	err = ptrace_getfpregs(userspace_pid[0], fpregs);
> -	if(err < 0){
> -	  	printk("copy_sc_to_user_skas - PTRACE_GETFPREGS failed, "
> -		       "errno = %d\n", err);
> -		return(1);
> +	if (have_fpx_regs) {
> +	    fp->cw = (unsigned long)*(unsigned short *)fp->_fxsr_env | 0xffff0000ul;
> +	    fp->sw = (unsigned long)*((unsigned short *)fp->_fxsr_env+1) | 0xffff0000ul;
> +	    fp->tag = twd_fxsr_to_i387(fp);
> +	    fp->ipoff = fp->_fxsr_env[2];
> +	    fp->cssel = fp->_fxsr_env[3] |
> +			((unsigned long)*((unsigned short *)fp->_fxsr_env+3) << 16);
> +	    fp->dataoff = fp->_fxsr_env[4];
> +	    fp->datasel = fp->_fxsr_env[5];
> +	    fp->status = (unsigned short)(fp->sw & 0xfffful);
> +	    fp->magic = 0;
> +	    for ( i=0; i<8; i++)
> +		memcpy(fp->_st+i, fp->_fxsr_st+i, sizeof(struct _fpreg));
> +	    size = sizeof(struct _fpstate);
> +	}
> +	else {
> +	    *(unsigned long *)&fp->status = fp->sw;
> +	    size = sizeof(regs->regs.skas.fp);
>  	}
>  	to_fp = (to_fp ? to_fp : (struct _fpstate *) (to + 1));
>  	sc.fpstate = to_fp;
>  
> -	if(err)
> -	  	return(err);
> -
>  	return(copy_to_user(to, &sc, sizeof(sc)) ||
> -	       copy_to_user(to_fp, fpregs, sizeof(fpregs)));
> +	       copy_to_user(to_fp, fp, size));
>  }
>  #endif
>  
> --- arch/um/kernel/skas/util/mk_ptregs-i386.c.orig	2004-12-23 10:46:41.143243494 +0100
> +++ arch/um/kernel/skas/util/mk_ptregs-i386.c	2004-12-23 11:08:01.272251951 +0100
> @@ -13,8 +13,9 @@
>  	printf("#define __SKAS_PT_REGS_\n");
>  	printf("\n");
>  	printf("#define HOST_FRAME_SIZE %d\n", FRAME_SIZE);
> +	/* This needs to have space for "status", too */
>  	printf("#define HOST_FP_SIZE %d\n", 
> -	       sizeof(struct user_i387_struct) / sizeof(unsigned long));
> +	       sizeof(struct user_i387_struct) / sizeof(unsigned long) + 1);
>  	printf("#define HOST_XFP_SIZE %d\n", 
>  	       sizeof(struct user_fxsr_struct) / sizeof(unsigned long));
>  


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
