Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Message-Id: <200404081134.i38BYZB6001887@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] A quick humfs HOWTO 
In-Reply-To: Your message of "Thu, 08 Apr 2004 10:35:48 +0200."
	<Pine.LNX.4.44.0404081027360.7910-100000@filer.marasystems.com> 
References: <Pine.LNX.4.44.0404081027360.7910-100000@filer.marasystems.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Thu, 08 Apr 2004 07:34:35 -0400
To: Henrik Nordstrom <uml@henrik.marasystems.com>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

uml@henrik.marasystems.com said:
> Can data be a symlink on the host?

Yup.

> I would suggest adding an option to optionally allow specifying the
> path to data, this to allow humfs permission shadows to easily be
> created of existing trees. If data can be a symlink this option can be
> managed in humfsify.

With humfsify currently, you set up the data tree, and it takes it from there.
So you can make data a symlink, and it will just work.

At some point, I'll have humsify create the data tree as well, and then it
will be possible to tell it to make it a symlink.

> Also, what happens if there is a mismatches between metadata and data
> content? 

Bad things happen.  The filesystem still needs to be hardened against 
mismatches.

> I wouldsuggest adding a read-only flag, preventing UML from mounting
> the  directory read-write. 

Good idea.

> How is this information used by humfsify? Can these be made optional
> (then  use current uid/gid, or don't care) 

Don't care isn't a possibility.  humfsify chowns everything in the data tree
to this uid and gid.  UML needs write access to everything if root is to
behave as root.

Possible it could run as a normal user, but my expectation is that people
will loop-mount ubd volumes as their data sources, and those are filled with
root-owned files.  The only place that makes sense is when you already have
a tree which is completely owned by the UML user.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
