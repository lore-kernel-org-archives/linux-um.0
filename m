Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BQCBc-0003x1-4T for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 14:31:44 -0700
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.30)
	id 1BQCBb-00061b-Ej for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 18 May 2004 14:31:43 -0700
Message-ID: <085c01c43d20$7f13fa40$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <20040518180259.GC29114@ccure.user-mode-linux.org>
	<Pine.LNX.4.44.0405182131440.10300-100000@filer.marasystems.com>
	<20040518220017.GA29646@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] CVS not updated?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
Date: Tue, 18 May 2004 23:38:44 +0200
To: Jeff Dike <jdike@addtoit.com>, Henrik Nordstrom <uml@hno.marasystems.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

>I find the UML is way better for CVS than SF.  It's very much faster.
i can agree, that the SF anoncvs is a horror (at least i remember it WAS a horror, when i used it some time ago).
afaik, behaviour with non-anon cvs usage on sourceforge was quite different - so only anoncvs-users had big problems.

regards
roland

----- Original Message ----- 
From: "Jeff Dike" <jdike@addtoit.com>
To: "Henrik Nordstrom" <uml@hno.marasystems.com>
Cc: <user-mode-linux-devel@lists.sourceforge.net>
Sent: Wednesday, May 19, 2004 12:00 AM
Subject: Re: [uml-devel] CVS not updated?


> On Tue, May 18, 2004 at 09:42:13PM +0200, Henrik Nordstrom wrote:
> > >From the error message I think you are missing a "anonymous" system user
> > or a suitable mapping in your CVS password file to another suitable system 
> > user..
> > 
> > The CVS password file format is
> > 
> > login:[password][:unixuser]
> > 
> > if the unixuser is not specified the login is used..
> > 
> > Example for anonymous CVS with pubcvs as the UNIX user
> > 
> >   anonymous::pubcvs
> 
> Thanks for your help.  It looks like it works now.
> 
> > I can offer to login to try to fix the problem if the above does not help.  
> > My SSH keys can be found at http://marasystems.com/people/hno/,
> > http://www.squid-cache.org/~hno/ or
> > http://hem.passagen.se/hno/Welcome.html
> 
> You have an account on www.user-mode-linux.org, if you want to have a look
> at the CVS setup.  I'd especially appreciate a look at the security since
> I haven't done anything in particular to lock it down.
> 
> > I was on the edge to move my projects from SF about 6 months ago due to
> > the numerous CVS issues, but they have managed to restore the quality of
> > their service and today the only reason I see to not use SF for my 
> > projects is if I were to use another revision control system such as 
> > arch or subversion.. but at the moment I find CVS works very well for my 
> > purposes..
> 
> I find the UML is way better for CVS than SF.  It's very much faster.
> 
> Also, I'd like to be independent of SF in case VA starts having trouble
> or if they decide to start making access to project metadata difficult.
> You could argue that they already do (and I, in fact would), with their
>  insistence that everything be done through your browser.
> 
> With CVS moved, I now reply on SF for the web site, downloads, and mailing
> lists.  The lists will be the next to move.  The downloads will stay since
> SF is just one mirror of many, and it'll be easy to get rid of it if they
> start misbehaving.
> 
> The site will stay on SF until I get my UML-on-demand scheme working.  This
> involves spreading UML web server images around the net at various cooperative
> locations, like UML ISPs, having the server loads monitored by some central
> daemon, and that daemon starting up new UMLs and shutting them down as the
> load requires, using the nameserver to spread the load around.  Once I get
> this up and running, the site should be /.-proof, given that there's enough
> capacity available.
> 
> Jeff
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: SourceForge.net Broadband
> Sign-up now for SourceForge Broadband and get the fastest
> 6.0/768 connection for only $19.95/mo for the first 3 months!
> http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
