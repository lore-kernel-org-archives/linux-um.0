Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
In-Reply-To: <CAKiyQA_DFqAKWF2_wU52WURf5+8NkQecE4dqQLtn4VMcFT0G9w@mail.gmail.com>
References: <CAKiyQA_DFqAKWF2_wU52WURf5+8NkQecE4dqQLtn4VMcFT0G9w@mail.gmail.com>
Date: Sat, 25 Aug 2012 12:38:07 +0200
Message-ID: <CAFLxGvww2Usz+ZuQTHS3DG7oFOA0nfJ8oicOSaXKnNc_fqJnWw@mail.gmail.com>
From: richard -rw- weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [uml-user] SMP on UML
To: Dragos Diaconescu <diaconescud@gmail.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Fri, Aug 24, 2012 at 6:19 PM, Dragos Diaconescu
<diaconescud@gmail.com> wrote:
> Hello,
>
> I try to compile the UML, from a linux kernel(make ARCH=3Dum SUBARCH=3Di3=
86)
> and I have configured it to use SMP (make config). I am getting the
> following error:
>
>   CHK     include/generated/utsrelease.h
>   CC      arch/um/kernel/asm-offsets.s
> In file included from include/linux/sched.h:77:0,
>                  from
> /home/dragos/work/linux-3.5.2/arch/x86/um/shared/sysdep/kernel-offsets.h:=
2,
>                  from arch/um/kernel/asm-offsets.c:1:
> include/linux/topology.h: In function =91numa_node_id=92:
> include/linux/topology.h:217:9: error: =91current_thread=92 undeclared (f=
irst
> use in this function)
> include/linux/topology.h:217:9: note: each undeclared identifier is repor=
ted
> only once for each function it appears in
> include/linux/topology.h:217:9: warning: left-hand operand of comma
> expression has no effect [-Wunused-value]
> make[1]: *** [arch/um/kernel/asm-offsets.s] Error 1
>
> Do you have any ideas?

config SMP
        bool "Symmetric multi-processing support (EXPERIMENTAL)"
        default n
        depends on BROKEN
        help
          This option enables UML SMP support.

/me really wonders why you have CONFIG_BROKEN=3Dy :-)

-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

