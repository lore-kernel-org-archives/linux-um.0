Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19ueEl-0000bN-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 03 Sep 2003 13:28:19 -0700
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19ueEl-0005Gz-Dm
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 03 Sep 2003 13:28:19 -0700
Received: from 216-15-124-77.c3-0.smr-ubr3.sbo-smr.ma.cable.rcn.com ([216.15.124.77] helo=mizar.alcor.net)
	by smtp01.mrf.mail.rcn.net with esmtp (Exim 3.35 #4)
	id 19ueEj-00066B-00
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 03 Sep 2003 16:28:17 -0400
Received: from mdz by mizar.alcor.net with local (Exim 3.36 #1 (Debian))
	id 19ueEj-0003aU-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 03 Sep 2003 16:28:17 -0400
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] Creating virtual consoles on the fly
Message-ID: <20030903202817.GX7304@alcor.net>
References: <10C160F5A03A0942A1A87B658784CA6A0A4928@gummo.domain.trailerparc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10C160F5A03A0942A1A87B658784CA6A0A4928@gummo.domain.trailerparc.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 3 Sep 2003 16:28:17 -0400
To: user-mode-linux-devel@lists.sourceforge.net

On Wed, Sep 03, 2003 at 12:59:34PM -0700, Michael Talyansky wrote:

> Is there a programmatic way to create a virtual console on the fly, that
> is, without changing /etc/inittab and doing something like "telinit q"? 

inittab isn't magic; all it does is to run programs as appropriate for the
current runlevel.  You can run the same programs manually.

-- 
 - mdz


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
