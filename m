Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DSGy6-0001DX-6e	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 May 2005 09:06:54 -0700
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252] ident=93)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)	id 1DSGy4-00030U-Ky
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 01 May 2005 09:06:54 -0700
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [uml-devel] Re: [UML] Compile error when building with seperate
	source and object directories
Message-ID: <20050501160707.GI13052@parcelfarce.linux.theplanet.co.uk>
References: <1114570958.5983.50.camel@mythical>
	<20050428202647.GA25451@ccure.user-mode-linux.org>
	<20050428215328.GC13052@parcelfarce.linux.theplanet.co.uk>
	<200505011330.58205.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505011330.58205.blaisorblade@yahoo.it>
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
Date: Sun, 1 May 2005 17:07:07 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, sam@ravnborg.org, Ryan Anderson <ryan@michonline.com>

On Sun, May 01, 2005 at 01:30:57PM +0200, Blaisorblade wrote:
> For now I've added an #ifdef to re-include that code for x86, while excluding 
> it for x86_64. Also, is that up-to-date wrt. 2.6.12-rc3?

Yes, it is.  As for the ptrace.c...  IMO the right thing is per-architecture
helper here.  Such ifdefs are OK when it's just i386 and amd64.  As soon
as e.g. uml/s390 gets merged or uml/ia64 and uml/ppc get resurrected...


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
