Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E7E7X-0000Ev-DA	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2005 08:21:55 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1E7E7S-000718-GJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2005 08:21:55 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Possible SKAS3 >= v8 bug
References: <42FB5D26.5020703@theshore.net> <42FBBDF8.2020206@theshore.net>
	<42FBF41A.5090105@theshore.net>
In-Reply-To: <42FBF41A.5090105@theshore.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508211429.56287.blaisorblade@yahoo.it>
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
Date: Sun, 21 Aug 2005 14:29:56 +0200
To: "Christopher S. Aker" <caker@theshore.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

On Friday 12 August 2005 02:58, Christopher S. Aker wrote:
> Perhaps this is related.  I've upgraded one of the affected machines to
> 2.6.13-rc6.  We'll see how it goes...
>
> http://marc.theaimsgroup.com/?t=111720640400002&r=1&w=2
>
> -Chris
Ok, I'm particularly suspicious of one patch, ptrace_ldt-reload-smp-fix, try 
unapplying that one. I don't know exactly *how* it might trigger that crash, 
but it seems a data corruption, and that code is doing exactly that.

In addition, below, the segment selector is totally fucked up. It is a ring 0 
GDT segment, which is however non existant. It would exist only if there were 
a third CPU, and would be a NULL descriptor anyway.

EIP:    0200:[<00000000>]    Not tainted VLI
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
