Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CuYTl-0001bL-7O for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Jan 2005 07:56:13 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CuYTF-0006JD-4z for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 28 Jan 2005 07:56:13 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] skas3 patch breaks ATI video drivers
References: <41F54FE9.7060503@better.se>
In-Reply-To: <41F54FE9.7060503@better.se>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jBm+BlHYimYYm7M"
Message-Id: <200501281655.15452.blaisorblade@yahoo.it>
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
Date: Fri, 28 Jan 2005 16:55:13 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Marcus Better <marcus@better.se>

--Boundary-00=_jBm+BlHYimYYm7M
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 24 January 2005 20:43, Marcus Better wrote:
> Hi all,
>
> I applied Blaisorblade's host-skas3-2.6.9-v7.patch, and it breaks the
> fglrx graphics driver from ATI[1]. This is with Debian kernel 2.6.9, but
> I believe it applies to vanilla kernels also.

> The problem is the following declaration added to include/asm-i386/desc.h:

> ----------------------------------------------------------
> extern int modify_ldt(struct mm_struct * mm, int func, void __user *ptr,
>         unsigned long bytecount);
> ----------------------------------------------------------
>
> The fglrx driver contains the following macro in a source file:
>
> _syscall3( int, modify_ldt, int, func, void *, ptr, unsigned long,
> bytecount )
>
> Here the compiler chokes with the following error:
> ---------------------------------------------------------
> /usr/src/modules/fglrx-4.3.0-3.14.6/firegl_public.c:181: error:
> conflicting types for `modify_ldt'
> include/asm/desc.h:144: error: previous declaration of `modify_ldt'
> ---------------------------------------------------------
>
> I don't understand the details of the kernel code, but it seems that the
> problem is that the SKAS patch defines the function modify_ldt which
> conflicts with the syscall macros.
>
> I renamed the new function to _modify_ldt instead (and changed the two
> or three references to it in ldt.c), and this seems to fix the problem.
You should also have modified the reference inside arch/i386/kernel/ptrace.c.

I'm doing compilation-testing of the attached patch, which seems to be good 
(it is not the kind of patch easy to get wrong, however).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

--Boundary-00=_jBm+BlHYimYYm7M
Content-Type: text/x-diff; charset="iso-8859-1";
	name="rename-modify-ldt-to-avoid-conflicts.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="rename-modify-ldt-to-avoid-conflicts.patch"


SKAS adds a function modify_ldt (closely related to sys_modify_ldt) but the
declaration conflicts with some external code (ATI kernel modules). Since the
name is not important, rename the function to __modify_ldt.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 vanilla-linux-2.6.9-paolo/arch/i386/kernel/ldt.c    |    4 ++--
 vanilla-linux-2.6.9-paolo/arch/i386/kernel/ptrace.c |    2 +-
 vanilla-linux-2.6.9-paolo/include/asm-i386/desc.h   |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff -puN include/asm-i386/desc.h~rename-modify-ldt-to-avoid-conflicts include/asm-i386/desc.h
--- vanilla-linux-2.6.9/include/asm-i386/desc.h~rename-modify-ldt-to-avoid-conflicts	2005-01-28 16:23:44.334069944 +0100
+++ vanilla-linux-2.6.9-paolo/include/asm-i386/desc.h	2005-01-28 16:24:48.033386176 +0100
@@ -126,7 +126,7 @@ static inline void load_LDT(mm_context_t
 	put_cpu();
 }
 
-extern int modify_ldt(struct mm_struct * mm, int func, void __user *ptr,
+extern int __modify_ldt(struct mm_struct * mm, int func, void __user *ptr,
 		      unsigned long bytecount);
 
 #endif /* !__ASSEMBLY__ */
diff -puN arch/i386/kernel/ptrace.c~rename-modify-ldt-to-avoid-conflicts arch/i386/kernel/ptrace.c
--- vanilla-linux-2.6.9/arch/i386/kernel/ptrace.c~rename-modify-ldt-to-avoid-conflicts	2005-01-28 16:23:44.407058848 +0100
+++ vanilla-linux-2.6.9-paolo/arch/i386/kernel/ptrace.c	2005-01-28 16:24:48.037385568 +0100
@@ -562,7 +562,7 @@ asmlinkage int sys_ptrace(long request, 
 			ret = -EIO;
 			break;
 		}
-		ret = modify_ldt(child->mm, ldt.func, ldt.ptr, ldt.bytecount);
+		ret = __modify_ldt(child->mm, ldt.func, ldt.ptr, ldt.bytecount);
 		break;
 	}
 
diff -puN arch/i386/kernel/ldt.c~rename-modify-ldt-to-avoid-conflicts arch/i386/kernel/ldt.c
--- vanilla-linux-2.6.9/arch/i386/kernel/ldt.c~rename-modify-ldt-to-avoid-conflicts	2005-01-28 16:23:44.441053680 +0100
+++ vanilla-linux-2.6.9-paolo/arch/i386/kernel/ldt.c	2005-01-28 16:24:48.101375840 +0100
@@ -238,7 +238,7 @@ out:
 	return error;
 }
 
-int modify_ldt(struct mm_struct * mm, int func, void __user *ptr,
+int __modify_ldt(struct mm_struct * mm, int func, void __user *ptr,
 	       unsigned long bytecount)
 {
 	int ret = -ENOSYS;
@@ -262,5 +262,5 @@ int modify_ldt(struct mm_struct * mm, in
 
 asmlinkage int sys_modify_ldt(int func, void __user *ptr, unsigned long bytecount)
 {
-	return modify_ldt(current->mm, func, ptr, bytecount);
+	return __modify_ldt(current->mm, func, ptr, bytecount);
 }
_

--Boundary-00=_jBm+BlHYimYYm7M--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
