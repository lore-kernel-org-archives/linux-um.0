Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CKlTo-0000js-5n for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 15:32:20 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1CKlTk-0003ma-Vt for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 21 Oct 2004 15:32:19 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] Re: Bad handling of invalif systemcalls
References: <4177D503.2030409@fujitsu-siemens.com>
	<200410212209.i9LM92FL005362@ccure.user-mode-linux.org>
In-Reply-To: <200410212209.i9LM92FL005362@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410220032.27182.blaisorblade_spam@yahoo.it>
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
Date: Fri, 22 Oct 2004 00:32:27 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>

On Friday 22 October 2004 00:09, Jeff Dike wrote:
> bstroesser@fujitsu-siemens.com said:
> > AFAICS, the only solution for this is using the PTRACE_O_TRACESYSGOOD
> > option. This option seems to be specific for linux, but the problem
> > maybe is specific for linux, too.
>
> Another solution is to read the instruction.
>
> However TRACESYSGOOD is cleaner.  My only concern is whether that limits
> the hosts that UML will run on.  If TRACESYSGOOD has been around for the
> 2.4 series, then that's OK.
>
> I would be tempted to #define SIGSYSCALL (SIGTRAP + 0x80) or something just
> to make the +0x80 bit less magic-looking.

It should be | 0x80, not + 0x80 (style issue). See the code in 
do_syscall_trace.

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
