Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtAJa-0006y1-A0 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 11:55:58 -0800
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CtAJW-0007vG-Jx for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 24 Jan 2005 11:55:58 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] skas3 patch breaks ATI video drivers
References: <41F54FE9.7060503@better.se>
In-Reply-To: <41F54FE9.7060503@better.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501242113.16569.blaisorblade@yahoo.it>
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
Date: Mon, 24 Jan 2005 21:13:16 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Marcus Better <marcus@better.se>

On Monday 24 January 2005 20:43, Marcus Better wrote:
> Hi all,
>
> I applied Blaisorblade's host-skas3-2.6.9-v7.patch, and it breaks the
> fglrx graphics driver from ATI[1]. This is with Debian kernel 2.6.9, but
> I believe it applies to vanilla kernels also.
>
> The problem is the following declaration added to include/asm-i386/desc.h:
>
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

> I renamed the new function to _modify_ldt instead (and changed the two
> or three references to it in ldt.c), and this seems to fix the problem.

I.e. the compilation problem is not in the kernel module, right? In this case, 
the problem is that you have /usr/include/asm symlinked to your kernel's 
include/asm-i386 directory, which is the wrong setup. However your solution 
should not give any problem.

If this is wrong, instead, then you are surely right... but then the solution 
you explain would be unlikely to fix anything... and the code would also be 
different, I guess. It's just a quick shoot however, so feel free to correct 
me.
> Please CC replies to me, I'm not subscribed to the list.

> Thanks for your work!
Thanks to you for using UML!
> Marcus B.
>
> [1] http://www.ati.com/support/drivers/linux/radeon-linux.html

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
