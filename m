Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C8iis-0004zk-BX for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Sep 2004 10:10:06 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1C8iir-0005Dz-GI for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 18 Sep 2004 10:10:06 -0700
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] [patch] host-skas3 for 2.6.9-rc2
References: <200409122004.41777.blaisorblade_spam@yahoo.it>
	<20040916110323.GB12785@bytesex> <20040916133921.GA14509@bytesex>
In-Reply-To: <20040916133921.GA14509@bytesex>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409181856.44696.blaisorblade_spam@yahoo.it>
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
Date: Sat, 18 Sep 2004 18:56:44 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Gerd Knorr <kraxel@bytesex.org>

On Thursday 16 September 2004 15:39, Gerd Knorr wrote:
> On Thu, Sep 16, 2004 at 01:03:23PM +0200, Gerd Knorr wrote:
> > Some change between -rc1 and -rc1-bk1 broke the skas patch, still
> > looking ...
>
> Found it: init_new_empty_context needs a arch_pick_mmap_layout call,
> otherwise we'll get a NULL ptr dereferences for the function pointers
> added recently to mm_struct.
Well, please cleanup it, because you are affecting the behaviour on fork() 
(the change should be harmless, however, just repeating 
arch_pick_mmap_layout()).

Without the SKAS patch, init_new_context does not call 
arch_pick_mmap_layout(), so it should not after ( and init_new_context calls, 
actually, init_new_empty_context()). I think that the proper place to add the 
call is open_proc_mm(). Do you agree on this?

Bye
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
