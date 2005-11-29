Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Eh8io-0005sZ-Ti for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 08:52:50 -0800
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Eh8ij-00032v-BJ
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 29 Nov 2005 08:52:48 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] When /tmp is not tmpfs.
References: <200511240611.02613.rob@landley.net>
	<200511272020.52664.blaisorblade@yahoo.it>
	<200511271541.12899.rob@landley.net>
In-Reply-To: <200511271541.12899.rob@landley.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200511291752.31722.blaisorblade@yahoo.it>
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
Date: Tue, 29 Nov 2005 17:52:31 +0100
To: Rob Landley <rob@landley.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Nix <nix@esperi.org.uk>, Chris Lightfoot <chris@ex-parrot.com>

On Sunday 27 November 2005 22:41, Rob Landley wrote:
> On Sunday 27 November 2005 13:20, Blaisorblade wrote:

> *shrug*  The same argument could be made about any other argument that
> mount interprets.  (Currently: loop, defaults, noauto, ro, rw, nosuid,
> suid, dev, nodev, exec, noexec, sync, async, remount, atime, noatime,
> diratime, nodiratime, bind, move, and rbind.)

No, it's not the same story. What keeps both pieces together is mount being a 
de-facto standard.

Any fs coder who takes one of that as an fs option will have his head lopped 
at the very moment he does it.

So, start making busybox mount incompatible with util-linux mount (I mean for 
features, not for "undefined behaviour" situations) and you'll break stuff.

( I didn't know about diratime... )

> And no, I didn't invent mount interpreting any of that.  I can make it
> depend on loopback support (which is already a config option for mount; you
> can disable features out of the apps in busybox to shrink the size).

> Rob

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
