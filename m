Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BFdLT-0005xn-IK for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2004 11:18:15 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BFdLS-0002QO-U3
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 19 Apr 2004 11:18:15 -0700
Message-Id: <200404191858.i3JIwFsP024786@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Thoughts on HUMFS and metadata 
In-Reply-To: Your message of "Mon, 19 Apr 2004 09:52:49 +0200."
	<8D87591F-91D6-11D8-8B4A-000A95CD704C@kungfoocoder.org> 
References: <8D87591F-91D6-11D8-8B4A-000A95CD704C@kungfoocoder.org> 
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
Date: Mon, 19 Apr 2004 14:58:15 -0400
To: Paul Wagland <paul@kungfoocoder.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

paul@kungfoocoder.org said:
> 1. Do files really need to exist in data if they are block, character
>  or sockets? Surely it is enough to just look at the metadata for
> these   files and create the appropriate dir entry in the UML. 

Permissions are stored with the real file.  This makes "metadata" a bit of a 
misnomer - I just moved the information that absolutely needed to move.

> 2. When COW humfs "partitions" are made, will it be possible to
> separately copy metadata and data? For instance, if I change only the
>  uid, gid and/or permissions, do I need to also create a new copy of
> the   data, or can I only update my local metadata and use the data
> from the   parent?

A suitable implementation could optimize the COWing of permissions and other
non-data.  I'm not sure how worth-while that would be.

> 3. When COW humfs "partitions" are made, how will files be deleted in
>  the second humfs? I would assume (but could easily be wrong ;-) )
> that   the easiest way to do COW is for every file access, first check
> your   humfs, if it does not exist, then check your parent humfs. If
> this is   done, then how do you delete a file? I can see that one easy
> option is   to introduce a "deleted" metadata node, that only contains
> the word   deleted, and would signify that this file does not exist in
> this COWed   copy.

That's the plan, more or less.

> 4. Since metadata is basically a copy of "permission data" does it
> also   make sense for humfs metadata to include things like
> capabilities and   ACL's? 

If they are stored in the filesystem, then it might make sense.

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
