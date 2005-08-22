Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E7EAE-0000NQ-30	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2005 08:24:42 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1E7EAD-0007dd-HP
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Aug 2005 08:24:42 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Hang at delay loop calibration
References: <20050812200118.GA8508@paktahn.black.cat>
In-Reply-To: <20050812200118.GA8508@paktahn.black.cat>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508221655.57342.blaisorblade@yahoo.it>
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
Date: Mon, 22 Aug 2005 16:55:56 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: leslie.polzer@gmx.net

On Friday 12 August 2005 22:01, leslie.polzer@gmx.net wrote:
> % linux
> Checking for the skas3 patch in the host...not found
> Checking for /proc/mm...not found
> tracing thread pid = 8456
> Checking for /dev/anon on the host...Not available (open failed with errno
> 2) Checking for /dev/anon on the host...Not available (open failed with
> errno 2) Checking for /dev/anon on the host...Not available (open failed
> with errno 2) Checking for /dev/anon on the host...Not available (open
> failed with errno 2) Linux version 2.4.26-1um (root@aries) (gcc version
> 3.4.0) #1 Sat Jul 3 00:22:45 PDT 2004 On node 0 totalpages: 8192
> zone(0): 8192 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: root=/dev/ubd0
> Calibrating delay loop...
Don't use anything less than 2.4.26-3um (there are known bugs in similar areas 
in such old kernel releases).

On my homepage you may find 2.4.28-bs2 which should be even stabler, but for 
UML you'll very likely find the 2.6 branch more stable (at least on the UML 
side, mainline side is different, but even there, UML has no "ACPI drivers" 
likely to break).

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
