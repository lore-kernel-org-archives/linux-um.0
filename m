Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKnfH-0001Wf-Fr for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 17:52:19 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1CKnfG-0006zO-Q3 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 17:52:19 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [patch 1/1] SYSEMU: avoid intercepting syscall on
	return when using SYSCALL again.
References: <20041021231834.9D3833F37@zion.localdomain>
In-Reply-To: <20041021231834.9D3833F37@zion.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200410220237.53212.blaisorblade_spam@yahoo.it>
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
Date: Fri, 22 Oct 2004 02:37:53 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: bstroesser@fujitsu-siemens.com, jdike@addtoit.com

On Friday 22 October 2004 01:18, blaisorblade_spam@yahoo.it wrote:
> From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

> A guest process switching from using PTRACE_SYSEMU to PTRACE_SYSCALL
> crashes.
>
> The problem is in arch/i386/kernel/entry.S. The current SYSEMU patch
> inhibits the syscall-handler to be called, but does not prevent
> do_syscall_trace to be called after this for syscall completion
> interception.
>
> The appended patch fixes this. It reuses the flag TIF_SYSCALL_EMU to
> remember "we come from PTRACE_SYSEMU and now are in PTRACE_SYSCALL", since
> the flag is unused in the depicted situation.
This version of the patch sets it during sys_ptrace(), instead of clearing it 
and re-enabling it as was being done. I'm going to test this version ASAP.

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
