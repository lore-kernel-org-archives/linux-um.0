Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19v57k-0005P0-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 04 Sep 2003 18:10:52 -0700
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19v57k-0001tb-9u
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 04 Sep 2003 18:10:52 -0700
Received: from 216-15-124-77.c3-0.smr-ubr3.sbo-smr.ma.cable.rcn.com ([216.15.124.77] helo=mizar.alcor.net)
	by smtp01.mrf.mail.rcn.net with esmtp (Exim 3.35 #4)
	id 19v57j-0007k1-00
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 04 Sep 2003 21:10:51 -0400
Received: from mdz by mizar.alcor.net with local (Exim 3.36 #1 (Debian))
	id 19v57i-0004xq-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 04 Sep 2003 21:10:50 -0400
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] hostfs as root
Message-ID: <20030905011050.GD16552@alcor.net>
References: <20030903191633.GV7304@alcor.net> <26941.1062723303@marajade.sandelman.ottawa.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26941.1062723303@marajade.sandelman.ottawa.on.ca>
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
Date: Thu, 4 Sep 2003 21:10:50 -0400
To: user-mode-linux-devel@lists.sourceforge.net

On Thu, Sep 04, 2003 at 08:55:03PM -0400, Michael Richardson wrote:

>   okay.. Makes sense. But, since they are mode 0, we can't open them as
> the user, which root inside could do. Is there some compromise that we can
> do until we have the permissions layer in place?
>   Like, forcing u+r on the underlying file maybe? 

The problem I ran into which led me to this bug was extracting tar archives.
When they contain read-only files, tar opens them for writing with read-only
permissions.  Since UML was creating the file and then, subsequently,
attempting to open it for writing, the second open failed.

I think that in general, having the permissions silently changed would be
unwise, though I admit that u-r permissions are weird at best.  It would
seem better to have mount fixed to stop doing this strange thing, and
eventually to emulate full permission control in hostfs.

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
