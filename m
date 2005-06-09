Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DgSP7-00042r-0E	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 12:09:25 -0700
Received: from mail.nagafix.co.uk ([213.228.237.37])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DgSP2-0006zW-Dw	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 09 Jun 2005 12:09:23 -0700
Subject: Re: SELinux for UML (was: Re: [uml-devel] 2.6.12-rc6-mm1 patches
	testing)
From: antoine <antoine@nagafix.co.uk>
In-Reply-To: <200506092026.24469.blaisorblade@yahoo.it>
References: <1118280325.10107.124.camel@localhost>
	 <200506091920.34246.blaisorblade@yahoo.it>
	 <1118339541.10190.105.camel@localhost>
	 <200506092026.24469.blaisorblade@yahoo.it>
Content-Type: text/plain
Message-Id: <1118344785.10190.141.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Date: Thu, 09 Jun 2005 20:19:45 +0100
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net

> > > > Yep, that part is much more specific to my setup: the place where you
> > > > install the UML instances is not part of the LSB, so I didn't include
> > > > the file labels in the previous email. What is the consensus on where
> > > > UML should be installed on a production system? (assuming multiple
> > > > instances + possibility of a chroot)
> > >
> > > There is no consensus, so that should be parametrized somehow (if
> > > policies don't have a builtin preprocessor, then sed is a good last
> > > resort - put the parameters inside %%, like %UML_ROOT_FS_PATH%, and use
> > > sed on that to produce the policy).
> 
> > It allows basic regular expressions with '.','*','?','+' and grouping
> > '()'.
> > I'm not too keen on sed because this would prevent the policy from being
> > merged upstream.
> Hmm, so there is a central repository of policies...
http://selinux.sourceforge.net/

Here is an interesting email I just received:
(it is about type enforcements .te but I expect the same principle to
apply to file contexts .fc)
******CUT
> > Generally
> > speaking, how do you maintain local customisations of the core policies?
> 
> No good answer yet.  There is presently support for local customization
> of boolean settings, file contexts, and users (at least in Fedora)
> without needing to touch policy sources.  For tweaks to .te rules, a
> common convention is to create domains/misc/local.te or
> domains/misc/custom.te.  The loadable module support that is in the
> process of being upstreamed will allow for well-defined policy modules
> with explicitly declared dependencies so you can define your own module
> without disturbing the base one provided by your distributor, but I
> think that support still only addresses the RBAC and TE rules, not
> things like network contexts.  The MLS work will require the ability to
> do site customization of netif contexts, so we'll likely have to add
> similar support to libsepol for local customizations there as we have
> already done for booleans and users.  That works by loading in the
> binary policy file into memory, loading in the local customization
> config files, mutating the in-memory policy image accordingly, and then
> loading the resulting policy image into the kernel.
******CUT

> > Maybe now is a good time to choose a directory by default and users who
> > deviate can use softlinks or tweak their policy.
> Hmm, well, who uses SELinux will have to setup things anyway, so they can even 
> move their files around. Assuming there will be a chroot too, using /chroot 
> (which is mandated by Who Knows Who, but is used on Gentoo for the dhcp 
> daemon) or better /chroot/uml would be good.
> 
> However, would a chroot work with SELinux or do you need to put the 
> "chrooting" also in the policy?
Well, I tried to define generic policies for my chrooted services when I
migrated them to selinux, but there are issues.
I'm looking into it.

> Btw, I really need to allow UML to chroot on its own, btw... and options for 
> changing UID/GID after setup...
That would be very nice.

I'll keep you posted as I learn more about SELinux and how to make UML
run smoothly in a chrooted/selinux environment.

Antoine



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
