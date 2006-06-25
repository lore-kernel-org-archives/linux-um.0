Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FuWyV-0006n8-Dr for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 08:56:39 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FuWyR-0005lO-Ng
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jun 2006 08:56:39 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sun, 25 Jun 2006 17:55:45 +0200
References: <E1FsiSR-0003HP-OO@sc8-sf-web5.sourceforge.net>
In-Reply-To: <E1FsiSR-0003HP-OO@sc8-sf-web5.sourceforge.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200606251755.45664.blaisorblade@yahoo.it>
Subject: Re: [uml-devel] possible um l bug
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jonathan  <jtester@users.sourceforge.net>
Cc: Jeff Dike <jdike@addtoit.com>, user-mode-linux-devel@lists.sourceforge.net

On Tuesday 20 June 2006 17:48, Jonathan wrote:
> Message body follows:

> I am using user-mode linux on 2.6.16.18

> I my .config everything is resident except some NFS
>> CONFIG_NFS_FS=m

> CONFIG_NFS_V3=y
> CONFIG_NFS_V3_ACL=y
> CONFIG_NFS_V4=y
> CONFIG_NFS_DIRECTIO=y
>> CONFIG_NFSD=m
> CONFIG_NFSD_V2_ACL=y
> CONFIG_NFSD_V3=y
> CONFIG_NFSD_V3_ACL=y
> CONFIG_NFSD_V4=y
> CONFIG_NFSD_TCP=y
>> CONFIG_NFS_ACL_SUPPORT=m
> CONFIG_NFS_COMMON=y
> CONFIG_NCPFS_NFS_NS=y

> This is compiled with -mcmodel=kernel

No, on x86_64 it is, but not on UML, because UML has a bug (totally forgot 
this). After analisying deeply the bug (below) I checked this very basic 
assertion, and found that a patch is needed. Please recompile and retest 
without the patch (to make sure it's repeatable and not showing up randomly) 
and with the patch (to make sure it's a sufficient fix; without the first 
test this wouldn't be a perfect proof about patch validity). Do a make clean 
before the 1st compile (the one without the patch); kbuild is smart enough to 
recompile everything when it sees flags have changed.

Jeff, please merge this, after Jonathan response, even for 2.6.17-stable.

> [root@localhost ~]# service rpcidmapd start
> Starting RPC idmapd: [42949986.800000] overflow in
> relocation type 11 val 80b85e70 loc = 80b85e70
> [42949986.800000] `sunrpc' likely not compiled with
> FATAL: Error inserting sunrpc
> (/lib/modules/2.6.16.18/kernel/net/sunrpc/sunrpc.ko):
> Invalid module format
> FATAL: Error running install command for sunrpc

> I track this down and find the message comes from the kernel in

> ./arch/um/sys-x86_64/module.c
For what I can see here, that file is a symlink from x86_64 code.
>                case R_X86_64_32S:
>                        *(s32 *)loc = val;
>                        if ((s64)val != *(s32 *)loc)
>                                goto overflow;
>                        break;
>                case R_X86_64_PC32:
>                        val -= (u64)loc;
>                        *(u32 *)loc = val;
> #if 0
>                        if ((s64)val != *(s32 *)loc)
>                                goto overflow;
> #endif
>                        break;
>                default:
>                        printk(KERN_ERR "module %s: Unknown
> rela relocation: %Lu\n",
>                               me->name,
> ELF64_R_TYPE(rel[i].r_info));
>                        return -ENOEXEC;
>                }
>        }
>        return 0;
>
> overflow:
>        printk(KERN_ERR "overflow in relocation type %d val
> %Lx loc = %x\n",
>               (int)ELF64_R_TYPE(rel[i].r_info), val,*(u32
> *)loc);
You're wrong in printing loc as u32. It's a s32 value. However your analisys 
is correct.

>        printk(KERN_ERR "`%s' likely not compiled with
> -mcmodel=kernel\n",
>               me->name);
>        return -ENOEXEC;
> }
>
> Note I added to one printk so I could find out what actually
> is happening.
>
> Where R_X86_64_32S has the value 11,
>
>
> From the first error message printed on the console
>
> Starting RPC idmapd: [42949986.800000] overflow in
> relocation type 11 val 80b85e70 loc = 80b85e70
>
> Both loc and val are appear equal (one is a 64 bit signed
> and one is a 32 bit signed, one would be
> negative and one positive, and that why they are not equal)

Yes, the analisys seems almost correct. I.e. the positive but > 2G signed 
address kept in the 64bit var is converted to a negative one with the same 
representation. However, if the value is supposed to be an address it's very 
strange since 

> is this a bug, that only happens in uml?
It's not uml-only related as the code is x86_64.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
