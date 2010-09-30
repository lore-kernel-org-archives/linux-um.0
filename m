Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Thu, 30 Sep 2010 16:04:05 +0530
Message-ID: <AANLkTi=pWfESR4au8iFXMJgROVr5z7My5b+9+6=aAfKZ@mail.gmail.com>
From: ratheesh k <ratheesh.ksz@gmail.com>
Subject: [uml-devel] nf_nat.h
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
To: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

When i included nf_nat.h in hook.c file and try to build a kernel
module ; fol lowing error comes

   from include/net/netfilter/nf_nat.h:57,
                 from /home/fox/workspace/hook.c:7:
include/net/netfilter/nf_conntrack.h:94: error: field =91ct_general=92 has
incomplete type
include/net/netfilter/nf_conntrack.h: In function =91nf_ct_get=92:
include/net/netfilter/nf_conntrack.h:178: error: =91const struct
sk_buff=92 has no member named =91nfct=92
include/net/netfilter/nf_conntrack.h: In function =91nf_ct_put=92:
include/net/netfilter/nf_conntrack.h:185: error: implicit declaration
of function =91nf_conntrack_put=92
include/net/netfilter/nf_conntrack.h: In function =91nf_ct_is_untracked=92:
include/net/netfilter/nf_conntrack.h:288: error: =91const struct
sk_buff=92 has no member named =91nfct=92
make[1]: *** [/home/fox/workspace/hook.o] Error 1
make: *** [_module_/home/fox/workspace] Error 2

---------------------------------------------------------------------------=
---
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

