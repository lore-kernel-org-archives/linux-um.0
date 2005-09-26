Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKJFm-0005wa-6B	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Sep 2005 10:28:30 -0700
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1EKJFd-0002fe-Cj
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Sep 2005 10:28:27 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: Writing on DM snapshots, and having no
	"mainstream" device (was: Re: Fw: [PATCH 1/7] Add dm-snapshot tutorial in
	Documentation)
References: <20050920163433.6081be3b.akpm@osdl.org>
	<200509232211.32238.blaisorblade@yahoo.it>
	<20050923211953.GG18976@agk.surrey.redhat.com>
In-Reply-To: <20050923211953.GG18976@agk.surrey.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509261703.01567.blaisorblade@yahoo.it>
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
Date: Mon, 26 Sep 2005 17:03:01 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Alasdair G Kergon <agk@redhat.com>, LKML <linux-kernel@vger.kernel.org>, user-mode-linux-user@lists.sourceforge.net

On Friday 23 September 2005 23:19, Alasdair G Kergon wrote:
> On Fri, Sep 23, 2005 at 10:11:31PM +0200, Blaisorblade wrote:
> > you can create snapshots *WITHOUT* having a snapshot-origin device

> Checking the code, yes you're correct.
> When that LVM2 code was developed you'd get an oops but it's been fixed.
You also "fixed" my assertion that snapshot-origin "base device" (parameter 
n.1) must be a DM device. Should I readd it too?

IIRC I checked the code and it looks up the first param as a DM device, even 
because the list of snapshot is maintained for DM devices, not for general 
block devices.

Right?
> Alasdair

-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade


		
___________________________________ 
Yahoo! Messenger: chiamate gratuite in tutto il mondo 
http://it.messenger.yahoo.com



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
