Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IkL42-0000p3-KE for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Oct 2007 07:49:02 -0700
Received: from one.firstfloor.org ([213.235.205.2] ident=personne)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IkL41-0000kr-Pd
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Oct 2007 07:49:02 -0700
Date: Tue, 23 Oct 2007 16:48:52 +0200
From: Andi Kleen <andi@firstfloor.org>
Message-ID: <20071023144852.GA27956@one.firstfloor.org>
References: <20071022124322.GB8181@ftp.linux.org.uk>
	<20071022124551.GA7438@elte.hu> <471D2ECC.6090209@goop.org>
	<20071022231927.GA30814@elte.hu> <471D389E.40609@goop.org>
	<20071023084546.GA17007@elte.hu> <p73wste7zy5.fsf@bingen.suse.de>
	<20071023131009.GA32298@elte.hu> <p73sl427wvu.fsf@bingen.suse.de>
	<20071023142006.GA9961@elte.hu>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20071023142006.GA9961@elte.hu>
Subject: Re: [uml-devel] User Mode Linux still doesn't build in 2.6.23-final.
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Ingo Molnar <mingo@elte.hu>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Paolo Giarrusso <p.giarrusso@gmail.com>, linux-kernel@vger.kernel.org, Nix <nix@esperi.org.uk>, Andi Kleen <andi@firstfloor.org>, Rob Landley <rob@landley.net>, Al Viro <viro@ftp.linux.org.uk>, WANG Cong <xiyou.wangcong@gmail.com>, Sam Ravnborg <sam@ravnborg.org>

On Tue, Oct 23, 2007 at 04:20:06PM +0200, Ingo Molnar wrote:
> 
> * Andi Kleen <andi@firstfloor.org> wrote:
> 
> > >> You should rename it then to "asmcall" or something.
> > >
> > > if then that should be a separate renaming patch.
> > 
> > Well you're asking for the ugly hacks for out of tree code.  [...]
> 
> nice word-bending there. I'm asking for pre-existing annotations to 
> survive. 

What I'm objecting to is that you ask for this for your out of 
tree code without any justification on why exactly -- -pg should
in theory work with -mregparms. 

It's standard policy to require very good reasons for changes
that are only useful for out of tree code.  People get flamed
for this all the time so I'm doing this thankless job here too.

Is it just because you didn't want to adapt the tracer for i386 regparm?
(that would be an invalid reason in my opinion ;-)
The correct fix would be to adapt the tracer then.

Or is it because gcc miscompiles something on i386 with -mregparm -pg?
(if yes that would be a valid reason, but it should be clearly stated) 

-Andi


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
