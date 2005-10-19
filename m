Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ES1lD-00055a-UH	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Oct 2005 17:24:51 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1ES1lC-0005sc-6O
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 Oct 2005 17:24:51 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [PATCH] build fix for uml/amd64
References: <20051018214517.GD7992@ftp.linux.org.uk>
In-Reply-To: <20051018214517.GD7992@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510190226.03582.blaisorblade@yahoo.it>
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
Date: Wed, 19 Oct 2005 02:26:02 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Al Viro <viro@ftp.linux.org.uk>, Linus Torvalds <torvalds@osdl.org>, jdike@addtoit.com, linux-kernel@vger.kernel.org

On Tuesday 18 October 2005 23:45, Al Viro wrote:
> 	Missing half of the [PATCH] uml: Fix sysrq-r support for skas mode
> We need to remove these (UPT_[DEFG]S) from the read side as well as the
> write one - otherwise it simply won't build.
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ----
>
> IMO it should go in before 2.6.14.  Jeff, could you ACK that?

Acked-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

and probably

Acked-by: Jeff Dike <jdike@addtoit.com>

(we already discussed this via IRC, but since I couldn't test the patch at the 
moment, I asked Jeff to send it in my place, and then I've been busy).

> diff -urN RC14-rc4-git4-hppfs-sparse/arch/um/include/sysdep-x86_64/ptrace.h
> RC14-rc4-git4-pending-1/arch/um/include/sysdep-x86_64/ptrace.h ---
> RC14-rc4-git4-hppfs-sparse/arch/um/include/sysdep-x86_64/ptrace.h	2005-10-1
>0 21:36:17.000000000 -0400 +++
> RC14-rc4-git4-pending-1/arch/um/include/sysdep-x86_64/ptrace.h	2005-10-16
> 03:10:04.000000000 -0400 @@ -183,10 +183,6 @@
>                  case RBP: val = UPT_RBP(regs); break; \
>                  case ORIG_RAX: val = UPT_ORIG_RAX(regs); break; \
>                  case CS: val = UPT_CS(regs); break; \
> -                case DS: val = UPT_DS(regs); break; \
> -                case ES: val = UPT_ES(regs); break; \
> -                case FS: val = UPT_FS(regs); break; \
> -                case GS: val = UPT_GS(regs); break; \
>                  case EFLAGS: val = UPT_EFLAGS(regs); break; \
>                  default :  \
>                          panic("Bad register in UPT_REG : %d\n", reg);  \

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
