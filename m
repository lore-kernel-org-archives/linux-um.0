Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BGIoW-0003Un-1m for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Apr 2004 07:35:00 -0700
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1BGIoV-0001pc-I1
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 21 Apr 2004 07:34:59 -0700
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20040421151519.GB7081@ccure.user-mode-linux.org>
References: <F87C6818-936D-11D8-B5AA-000A95CD704C@kungfoocoder.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F87C6818-936D-11D8-B5AA-000A95CD704C@kungfoocoder.org>
Subject: [uml-devel] Re: A few comments on hostfs interface
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
Date: Wed, 21 Apr 2004 11:15:19 -0400
To: Paul Wagland <paul@kungfoocoder.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, Piotr Neuman <sikkh@wp.pl>

On Wed, Apr 21, 2004 at 10:29:13AM +0200, Paul Wagland wrote:
>   struct externfs_file_ops:
>     Almost all of the functions have the naming form verb_noun, except 
> for file_create(). I would suggest to reverse this for the sake of 
> consistency.

Yup.  I'm schizophrenic on verb-noun vs noun-verb, sometimes within
the same interface, as you've noticed.
> 
>     Most functions have "long names" that is open_file, link_file, 
> access_file, etc. The exceptions to this are mkdir(), rmdir(), mknod(), 
> readlink(), and statfs(). This cannot be done to "keep standard 
> semantics" since open_dir() is not in it's standard form either. I 
> would suggest to rename all of the "short form" functions into the 
> standardised form.

Yup.

> Jeff, if you agree with the above, let me know, and you will receive a 
> patch for it later today.

OK, can you make it on top of sikkh's patch?

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
