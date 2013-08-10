Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <malattia@linux.it>) id 1V80rY-00026M-D2
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Aug 2013 04:33:12 +0000
Received: from ac250205.ppp.asahi-net.or.jp ([183.77.250.205]
	helo=smtp.kamineko.org)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V80rW-0005fy-6u for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 Aug 2013 04:33:12 +0000
Date: Sat, 10 Aug 2013 13:16:52 +0900
From: Mattia Dongili <malattia@linux.it>
Message-ID: <20130810041652.GA17743@kamineko.org>
References: <20130809204355.GA10864@redhat.com>
	<CAFLxGvxSdR48N+_kb+mNkamEKENP3uWEJB4MxFCTEh94oOcXog@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFLxGvxSdR48N+_kb+mNkamEKENP3uWEJB4MxFCTEh94oOcXog@mail.gmail.com>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] Using UML in libguestfs
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Fri, Aug 09, 2013 at 10:57:20PM +0200, richard -rw- weinberger wrote:
> On Fri, Aug 9, 2013 at 10:43 PM, Richard W.M. Jones <rjones@redhat.com> wrote:
> > Today I wrote some patches (for libguestfs) which add an experimental
> > UML backend:
> >
> >   https://www.redhat.com/archives/libguestfs/2013-August/msg00005.html
> >
> > There are some observations from this.
> >
> > * 'ubd<N>=cow,original' is not parsed correctly.  This was reported a
> > while back and I'm seeing the same thing with the latest kernel from
> > git:
> >
> >   http://thread.gmane.org/gmane.linux.uml.devel/13556
> >
> > If I have some time I'll have a go at fixing this since it seems like
> > a simple regression.
> 
> Patches are very welcome!
> 
> > * I'm trying to use a serial port to communicate between guest and
> > host, using ssl3=fd:<N>.  This causes the Linux process to crash soon
> > (but not immediately) after the guest has opened /dev/ttyS3:
> >
> >   spurious interrupt in ubd_handler, err = -4
> >
> > I've put the full call trace at the end of the email because it's
> > quite long[1].  This was also reported before, although the suggested
> > patch did not fix it:
> >
> >   http://marc.info/?l=linux-kernel&m=123242364211797&w=2
> >
> > I wonder if anyone has used the fd:<N> option in anger?  I will try
> > using a Unix domain socket and see if it makes a difference.
> 
> Hmmm. I *should* work.
> Which fd are you using?
> Can you also try pts?

just for the record, rootstrap in debian (script to create a debian FS)
uses that option
umlargs.extend(['con0=fd:0,fd:1',                                                                                                         
                'con=pts',                                                                                                                
                                'root=/dev/root',                                                                                         
                                'rootflags=/',                                                                                            
                                'rootfstype=hostfs',                                                                                      
                'ubd1=' + imagefile,                                                                                                      
                'init=/usr/lib/rootstrap/builder',                                                                                        
                'devfs=nomount',                                                                                                          
                'rsworkdir=' + os.getcwd()])                                                                                              

Last time I checked it worked.
-- 
mattia
:wq!

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

