Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EItuV-00084O-Ob	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Sep 2005 13:12:43 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EItuS-0004QY-Rg
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 23 Sep 2005 13:12:43 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20050920163433.6081be3b.akpm@osdl.org>
	<20050921154846.GW18976@agk.surrey.redhat.com>
In-Reply-To: <20050921154846.GW18976@agk.surrey.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509232211.32238.blaisorblade@yahoo.it>
Subject: [uml-devel] Writing on DM snapshots, and having no "mainstream"
	device (was: Re: Fw: [PATCH 1/7] Add dm-snapshot tutorial in Documentation)
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
Date: Fri, 23 Sep 2005 22:11:31 +0200
To: Alasdair G Kergon <agk@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net

On Wednesday 21 September 2005 17:48, Alasdair G Kergon wrote:
> On Tue, Sep 20, 2005 at 04:34:33PM -0700, Andrew Morton wrote:
> > ack?
>
> Applied some quick corrections to this.
I'm now looking at this, but you've done an error. You say that 

You must create the snapshot-origin device before you can create snapshots.

This is totally wrong. The whole point of my document is to show that you can 
create snapshots *WITHOUT* having a snapshot-origin device (yes, I did it).

And while the LVM setup (with snapshot-origin) is often used and well known, 
the possibility to do without the snapshot-origin, and more important to 
write on the snapshots, is something which is not widely known at all.

In fact, UML community has been using an in-house version of the same feature, 
which cannot be mounted on the host due to missing code.
> See also http://people.redhat.com/agk/talks/FOSDEM_2005/
> (slides 15-27)
Not yet had time to look at those, sorry.
> You might like to convert some of those diagrams to ASCII
> and include them?
If you feel like doing this, ok, but I'm not normally a documentor.
> Alasdair

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
