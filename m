Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19uZoi-0003Xp-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 03 Sep 2003 08:45:08 -0700
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19uZoi-0000FJ-9W
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 03 Sep 2003 08:45:08 -0700
Received: from 216-15-124-77.c3-0.smr-ubr3.sbo-smr.ma.cable.rcn.com ([216.15.124.77] helo=mizar.alcor.net)
	by smtp01.mrf.mail.rcn.net with esmtp (Exim 3.35 #4)
	id 19uZog-0002Nl-00
	for user-mode-linux-devel@lists.sourceforge.net; Wed, 03 Sep 2003 11:45:06 -0400
Received: from mdz by mizar.alcor.net with local (Exim 3.36 #1 (Debian))
	id 19uZog-0002cI-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Wed, 03 Sep 2003 11:45:06 -0400
From: Matt Zimmerman <mdz@debian.org>
Subject: Re: [uml-devel] uml-patch-2.4.20-7
Message-ID: <20030903154506.GL7304@alcor.net>
References: <200308071929.h77JTo5N017958@uml.karaya.com> <3F512995.4050209@vgertech.com> <200309021900.h82J0YHx001746@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309021900.h82J0YHx001746@ccure.karaya.com>
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
Date: Wed, 3 Sep 2003 11:45:06 -0400
To: user-mode-linux-devel@lists.sourceforge.net

On Tue, Sep 02, 2003 at 03:00:34PM -0400, Jeff Dike wrote:

> Since I can't break the existing
> 	ubdx=cow-file,backing-file
> syntax, that will need to continue to be supported.

Maybe it wouldn't be so bad to break the existing
    ubdx=cow-file
syntax, though?

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
