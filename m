Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19vOXD-0006e4-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Fri, 05 Sep 2003 14:54:27 -0700
Received: from 64.221.211.208.ptr.us.xo.net ([64.221.211.208] helo=mail.keyresearch.com)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 19vOX9-0004dI-Dl
	for user-mode-linux-devel@lists.sourceforge.net; Fri, 05 Sep 2003 14:54:23 -0700
Subject: Re: [uml-devel] SKAS: Why pass mm vs. current?
From: "Bryan O'Sullivan" <bos@keyresearch.com>
In-Reply-To: <20030905214737.GF1601@pathfinder>
References: <20030905020623.GA1601@pathfinder>
	 <200309052012.h85KCojh001348@ccure.karaya.com>
	 <20030905210818.GE1601@pathfinder>
	 <1062797281.23069.46.camel@serpentine.internal.keyresearch.com>
	 <20030905214737.GF1601@pathfinder>
Content-Type: text/plain
Message-Id: <1062798832.23069.56.camel@serpentine.internal.keyresearch.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: 05 Sep 2003 14:53:53 -0700
To: stevegt@TerraLuna.Org
Cc: user-mode-linux-devel@lists.sourceforge.net

On Fri, 2003-09-05 at 14:47, stevegt@TerraLuna.Org wrote:

> So that sounds like it answers one of my first questions -- there's
> actually no special context that needs to be preserved down through the
> call stack, so neither mm nor current need to be explicitly passed at
> all?

Um, of course mm needs passing in some form or another.

The whole point of the skas patches is to let a single process execute
with multiple different mm_structs, switching back and forth between
them under the control of the master process.

In order to do this, the host process has to have some way of telling
the slave which mm_struct to use.  Look at the changes to ptrace.c in
the patch and you'll see what's going on at the top level.  Everything
else kind of follows from that.

> If I fix this by creating a new patch, can we post it as skas3.1 or
> something?

SuSE already has a modified skas patch that fixes the interface breakage
in 2.4.  The 2.6 patch doesn't break any interfaces.  Jeff is likely to
have time to make a clean interface very soon.

Ergo, there's nothing much to be done.

	<b



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
