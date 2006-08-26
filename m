Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GGzrX-0001ED-A0 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Aug 2006 08:14:19 -0700
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1GGzrS-0005CQ-WC
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 26 Aug 2006 08:14:19 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Date: Sat, 26 Aug 2006 17:13:57 +0200
References: <1156500157.27177.269394882@webmail.messagingengine.com>
	<200608261519.10930.blaisorblade@yahoo.it>
	<1156600391.4730.4.camel@localhost>
In-Reply-To: <1156600391.4730.4.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608261713.57578.blaisorblade@yahoo.it>
Subject: [uml-devel] Wiki situation (was: Re: [uml-user] 2.6.17.10)
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Dalibor Dukic <dalibor.dukic@gmail.com>
Cc: Jeff Dike <jdike@addtoit.com>, Mathew Brown <mathewbrown@fastmail.fm>, user-mode-linux-devel@lists.sourceforge.net

On Saturday 26 August 2006 15:53, Dalibor Dukic wrote:
> On Sat, 2006-08-26 at 15:19 +0200, Blaisorblade wrote:
> > On Saturday 26 August 2006 14:11, Mathew Brown wrote:
> > > On Sat, 26 Aug 2006 13:07:59 +0200, "Blaisorblade"
> > >
> > > <blaisorblade@yahoo.it> said:
> > > > On Saturday 26 August 2006 12:41, Mathew Brown wrote:
> > > > > On Fri, 25 Aug 2006 16:47:38 +0200, "Dalibor Dukic"
> > > > >
> > > > > I mentioned this in my previous thread and Jeff redirected me to:
> > > > > http://uml.harlowhill.com/  Unfortunately, it's read only.
> > > >
> > > > Since when? It's never been so - likely you just need a free account
> > > > to edit
> > > > it. My info may be out of date but this is real (and strange) news.
> > > > --
> > >
> > > I'm not sure since when but it states so clearly on the main page:  "We
> > > seem to have a problem with wiki-spam from various sources. I am going
> > > to make the wiki read only while I resolve the problem & probably
> > > create a username/password system to help protect us from this evil
> > > scourge!"
> > >
> > > I didn't find any mention of where you can apply for a
> > > username/password..
> >
> > Ok, I didn't visit it so recently - sorry for not going to see myself
> > (I'm a bit busy).
> >
> > Jeff (and the wiki administrator - I don't know who is, please CC him),
> > given that we need a wiki and that sourceforge offers free PHP + MySQL
> > hosting (if things didn't change - this was true 2 years ago), do we need
> > to host the wiki or offer help to the admin or to help it in whichever
> > way?

> I can arrange hosting for free on my private server. It's not a problem.

That is not the problem. Thanks for your offer anyway.

The current problem with the wiki is that it must be setup against wiki-spam, 
and there are ways to do that:
* require a Username/password for changes, and ask to type chars in a 
distorted image during registration to stop bots.
* use a blacklist against spam: see 
http://linux-net.osdl.org/index.php/Main_Page (I discovered that because I 
was blacklisted once due to my bad provider).

However, since the wiki is privately hosted what happens if, for instance, the 
admin decides to close it because he doesn't support any more UML?

Or can we make sure backups are done (this is an example, nor Jeff nor I have 
much time for syst. administration, but configuring a cron job onto our 
machines is easy, and Sourceforge probably would help in this but it's to 
see)? What if the HD's on his box crash (not every server is on RAID)?

And so on. And on the other side, since we need a wiki we should also probably 
provide and support it. The current administrator is very kind but he filled 
a need we should have filled already.

Many other projects have a wiki as their _main_ website (even because 
collaborative work on a standard website is more difficult - keeping the 
sources in CVS is possible but in practice it didn't work for us). But this 
means that the website admin must be able to act on the wiki.

Don't misunderstand me, I don't want to refuse help from the community or 
consider it less, nor to criticize anybody, but the wiki _is_ important, and 
it should have a more central role.

These are just ideas, doubts and proposals to discuss together, and now I want 
to hear your ideas.

Thanks to everybody
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
