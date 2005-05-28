Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dc51Z-0007sL-Gp	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 May 2005 10:23:01 -0700
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]
	helo=ylpvm29.prodigy.net)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Dc51W-00087u-Ni	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 28 May 2005 10:23:01 -0700
Received: from pimout3-ext.prodigy.net (pimout3-int.prodigy.net
	[207.115.4.218])j4SHMhCg027686
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 28 May 2005 13:22:48 -0400
From: Chris Wedgwood <cw@f00f.org>
Message-ID: <f17872eaacd075b18c8af457590839dc.IBX@taniwha.stupidest.org>
References: <20050527003926.1FD861AEE92@zion.home.lan>
	<c915b004e775ff68517f3be2c95c6f93.IBX@taniwha.stupidest.org>
	<200505281326.15519.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505281326.15519.blaisorblade@yahoo.it>
Subject: [uml-devel] Re: [patch 1/1] [RFC] uml: add and use generic
	hw_controller_type->release
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
Date: Sat, 28 May 2005 10:22:26 -0700
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: Bodo Stroesser <bstroesser@fujitsu-siemens.com>, akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, mingo@redhat.com

On Sat, May 28, 2005 at 01:26:15PM +0200, Blaisorblade wrote:

> Well, that's a point, even because a conditional jump needs to flush
> the pipeline when mispredicted (which won't happen on other ARCHs
> after the initial period, if this jump stays in the Branch Target
> Buffers).

Because it's crud we are accumulating over time that nobody except UML
needs and maybe one day UML won't need it.  Also #ifdef's (though
ugly) would make it much more likely that it goes away when it can.


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
