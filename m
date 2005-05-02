Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DSgNX-0003QD-90	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 May 2005 12:14:51 -0700
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1DSgNV-0005Q0-KG	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 May 2005 12:14:51 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Re: [UML] Compile error when building with seperate
	source and object directories
References: <1114570958.5983.50.camel@mythical>
	<200505011330.58205.blaisorblade@yahoo.it>
	<20050501160707.GI13052@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050501160707.GI13052@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505022114.06062.blaisorblade@yahoo.it>
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
Date: Mon, 2 May 2005 21:14:05 +0200
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, sam@ravnborg.org, Ryan Anderson <ryan@michonline.com>

On Sunday 01 May 2005 18:07, Al Viro wrote:
> On Sun, May 01, 2005 at 01:30:57PM +0200, Blaisorblade wrote:
> > For now I've added an #ifdef to re-include that code for x86, while
> > excluding it for x86_64. Also, is that up-to-date wrt. 2.6.12-rc3?
>
> Yes, it is.  As for the ptrace.c...  IMO the right thing is
> per-architecture helper here.  Such ifdefs are OK when it's just i386 and
> amd64.  As soon as e.g. uml/s390 gets merged or uml/ia64 and uml/ppc get
> resurrected...
Agreed, I've done it this way to reintroduce for now the code for i386. It's 
anyway kludgy, since amd64 has too its debug registers to handle (at least it 
should); it's just that UML does not handle them yet.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
