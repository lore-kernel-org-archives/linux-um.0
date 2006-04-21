Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FX31r-0000i5-Qe for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Apr 2006 14:19:03 -0700
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FX31o-0004A5-Tg
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 21 Apr 2006 14:19:03 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] [RFC][PATCH] include /usr/lib/uml in PATH
References: <20060402173445.GB5108@inferi.kami.home>
	<200604070845.39534.blaisorblade@yahoo.it>
	<20060407165205.GE23715@inferi.kami.home>
In-Reply-To: <20060407165205.GE23715@inferi.kami.home>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200604212318.53467.blaisorblade@yahoo.it>
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
Date: Fri, 21 Apr 2006 23:18:52 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Mattia Dongili <malattia@linux.it>, Geert Uytterhoeven <geert@linux-m68k.org>, Jeff Dike <jdike@addtoit.com>

On Friday 07 April 2006 18:52, Mattia Dongili wrote:
> On Fri, Apr 07, 2006 at 08:45:38AM +0200, Blaisorblade wrote:
> > On Wednesday 05 April 2006 23:11, Mattia Dongili wrote:

> > In that case, you should append both IMHO - empty PATH and no PATH should
> > be treated the same way, I think.
>
> updated patch attached, I hope you like the if-statement .
>
> Description:
> append /usr/lib/uml to the existing PATH environment variable to let
> execvp search uml_net in FHS compliant locations.

> Signed-off-by: Mattia Dongili <malattia@linux.it>

Ok, very well done - thanks for your patience (I hadn't the time to apply my 
suggestions myself, but I realise I must have been fairly annoying), you've 
followed the (informal) process very well.

You'll probably later see that, especially when people on the other side have 
little time or are important, care to the way you communicate is also 
important.

Meanwhile I merged it as I said in another mail - sorry for the long delay, 
but I've been very busy.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
