Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rgb@redhat.com>) id 1WR4nh-0002fF-2N
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Mar 2014 19:08:17 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WR4nf-0005RW-3v for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Mar 2014 19:08:16 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s2LJ871Y011785
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Fri, 21 Mar 2014 15:08:08 -0400
Date: Fri, 21 Mar 2014 15:08:03 -0400
From: Richard Guy Briggs <rgb@redhat.com>
Message-ID: <20140321190803.GD16467@madcap2.tricolour.ca>
References: <1395266643-3139-1-git-send-email-eparis@redhat.com>
	<1395266643-3139-2-git-send-email-eparis@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1395266643-3139-2-git-send-email-eparis@redhat.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 2/4] UM: implement syscall_get_arch()
To: Eric Paris <eparis@redhat.com>
Cc: linux-audit@redhat.com, user-mode-linux-devel@lists.sourceforge.net

On 14/03/19, Eric Paris wrote:
> SH: define syscall_get_arch() for superh
> 
> This patch defines syscall_get_arch() for the um platform.  It adds a
> new syscall.h header file to define this.  It copies the HOST_AUDIT_ARCH
> definition from ptrace.h.  (that definition will be removed when we
> switch audit to use this new syscall_get_arch() function)

Why not just use:

diff --git a/arch/um/include/asm/syscall.h
b/arch/um/include/asm/syscall.h
new file mode 100644
index 0000000..fbcb2e4
--- /dev/null
+++ b/arch/um/include/asm/syscall.h
@@ -0,0 +1,9 @@
+#ifndef __ASM_UM_SYSCALL_H
+#define __ASM_UM_SYSCALL_H
+
+static inline int syscall_get_arch(void)
+{
+       return HOST_AUDIT_ARCH;
+}
+
+#endif /* __ASM_SH_SYSCALL_H */

> Signed-off-by: Eric Paris <eparis@redhat.com>
> Cc: user-mode-linux-devel@lists.sourceforge.net
> ---
>  arch/x86/um/asm/syscall.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 arch/x86/um/asm/syscall.h
> 
> diff --git a/arch/x86/um/asm/syscall.h b/arch/x86/um/asm/syscall.h
> new file mode 100644
> index 0000000..9fe77b7
> --- /dev/null
> +++ b/arch/x86/um/asm/syscall.h
> @@ -0,0 +1,15 @@
> +#ifndef __UM_ASM_SYSCALL_H
> +#define __UM_ASM_SYSCALL_H
> +
> +#include <uapi/linux/audit.h>
> +
> +static inline int syscall_get_arch(void)
> +{
> +#ifdef CONFIG_X86_32
> +	return AUDIT_ARCH_I386;
> +#else
> +	return AUDIT_ARCH_X86_64;
> +#endif
> +}
> +
> +#endif /* __UM_ASM_SYSCALL_H */
> -- 
> 1.8.5.3
> 
> --
> Linux-audit mailing list
> Linux-audit@redhat.com
> https://www.redhat.com/mailman/listinfo/linux-audit

- RGB

--
Richard Guy Briggs <rbriggs@redhat.com>
Senior Software Engineer, Kernel Security, AMER ENG Base Operating Systems, Red Hat
Remote, Ottawa, Canada
Voice: +1.647.777.2635, Internal: (81) 32635, Alt: +1.613.693.0684x3545

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

