Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Henrik Nordstrom <uml@henrik.marasystems.com>
Subject: Re: [uml-devel] A quick humfs HOWTO 
In-Reply-To: <200404081134.i38BYZB6001887@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.44.0404081405570.9689-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 8 Apr 2004 14:09:42 +0200 (CEST)
To: Jeff Dike <jdike@addtoit.com>
Cc: Henrik Nordstrom <uml@henrik.marasystems.com>, user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Thu, 8 Apr 2004, Jeff Dike wrote:

> Don't care isn't a possibility.  humfsify chowns everything in the data tree
> to this uid and gid.  UML needs write access to everything if root is to
> behave as root.

Ugh.. this should be removed and just documented as a requirement in my 
opinion, especially considering following of symlinks..

> Possible it could run as a normal user, but my expectation is that people
> will loop-mount ubd volumes as their data sources, and those are filled with
> root-owned files.  The only place that makes sense is when you already have
> a tree which is completely owned by the UML user.

Such as is the case if one today is using hostfs, or setting up a 
reasonable read-only access to some tree but wanting detailed permissions. 
Anyway, these are all extensions to the humfsify tool, not the filesystem 
as such so it should be pretty easy for anyone needing this to get it 
done.

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
