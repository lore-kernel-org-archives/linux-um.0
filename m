Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19wYnp-0003WR-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Mon, 08 Sep 2003 20:04:25 -0700
Received: from boof.brainfood.com ([146.82.138.61] helo=gradall.private.brainfood.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19wUsY-0004Lc-PU
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Sep 2003 15:53:02 -0700
From: Adam Heath <adam@doogie.org>
Subject: Re: [uml-devel] SKAS: Why pass mm vs. current?
In-Reply-To: <1062798832.23069.56.camel@serpentine.internal.keyresearch.com>
Message-ID: <Pine.LNX.4.44.0309081750120.26334-100000@gradall.private.brainfood.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Mon, 8 Sep 2003 17:51:14 -0500 (CDT)
To: Bryan O'Sullivan <bos@keyresearch.com>
Cc: stevegt@TerraLuna.Org, user-mode-linux-devel@lists.sourceforge.net

On 5 Sep 2003, Bryan O'Sullivan wrote:

> The whole point of the skas patches is to let a single process execute
> with multiple different mm_structs, switching back and forth between
> them under the control of the master process.

No.  The skas patch does *2* things.

One: Let a single process switch mm_structs.
Two: modify ptrace to do mappings on another process

The former is not really needed, and is just a bonus.  It makes the host's
process table less crowded.  It's not needed to do real a
separate-kernel-address-space.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
