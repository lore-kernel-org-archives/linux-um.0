Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1TyE-0006tZ-3u for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Feb 2005 10:32:18 -0800
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1D1TyB-0007CS-4V for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Feb 2005 10:32:17 -0800
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [PATCH] uml: support a separate build tree;
	support USER_OBJS dependencies
References: <opsl43d9yilfdzum@localhost.localdomain>
	<200502132151.j1DLoxnW003492@ccure.user-mode-linux.org>
	<opsl5r02lclfdzum@localhost.localdomain>
In-Reply-To: <opsl5r02lclfdzum@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502161930.55206.blaisorblade@yahoo.it>
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
Date: Wed, 16 Feb 2005 19:30:54 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Vadim Abrossimov <vadim_abrossimov@yahoo.com>, Jeff Dike <jdike@addtoit.com>

On Monday 14 February 2005 00:11, Vadim Abrossimov wrote:
> On Sun, 13 Feb 2005 16:50:59 -0500, Jeff Dike <jdike@addtoit.com> wrote:

> This is the patch for USER_OBJS:
Ok, I have two more requests, if possible:
1) add something like arch/um/Rules.make which is included everywhere needed 
and contains boilerplate, repeated code. Ideally that would also contain also 
these two lines:

USER_OBJS += $(filter %_user.o,$(obj-y))
USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))

which are common to everything. So, most changes to this stuff could be 
insulated.

2) There is an error in the patch (even in Al's idea): you must swap, in the 
below code, CFLAGS_$(notdir $@) and $(USER_CFLAGS), since the former must be 
able to override the latter.

At least arch/um/kernel/frame.o will miscompile with the current patch; from 
arch/um/kernel/Makefile

#This must override the default -fomit-frame-pointer
CFLAGS_frame.o := -fno-omit-frame-pointer

#Notice that this declaration is correct.
$(USER_OBJS) : %.o: %.c
        $(CC) $(USER_CFLAGS) $(CFLAGS_$(notdir $@)) -c -o $@ $<

And yes, this is a reason to use a common include instead of duplicating 
everything.
> +$(USER_OBJS) : c_flags = -Wp,-MD,$(depfile) $(CFLAGS_$(notdir $@))
> $(USER_CFLAGS)

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
