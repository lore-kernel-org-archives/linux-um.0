Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AChQ9-0002pO-00
	for <user-mode-linux-devel@lists.sourceforge.net>; Thu, 23 Oct 2003 08:30:41 -0700
Received: from web20209.mail.yahoo.com ([216.136.226.64])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.22)
	id 1ACglB-0002ff-4O
	for user-mode-linux-devel@lists.sourceforge.net; Thu, 23 Oct 2003 07:48:21 -0700
Message-ID: <20031023144628.88438.qmail@web20209.mail.yahoo.com>
From: =?iso-8859-1?q?Nelio=20Pereira?= <nelio_pereira@yahoo.com.br>
Subject: Re: [uml-devel] uml_switch
In-Reply-To: <3F97E59F.4050500@vgertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 23 Oct 2003 11:46:28 -0300 (ART)
To: Nuno Silva <nuno.silva@vgertech.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

The code itself doesn't seem very complicated. I just
would like to know how a message is transmited to its
recipient, then I could intercept this message in the
right place.

Nelio

 --- Nuno Silva <nuno.silva@vgertech.com> escreveu: > 
> 
> Nelio Pereira wrote:
> > Hi list..
> 
> Hi!
> 
> 
> > 
> > I'm using UML to benchmark a distributed protocol
> > (cluster membership service) on a virtual network.
> As
> > a way of injecting faults, I thought about
> changing
> > uml_switch so it would not forward every message
> it
> > receives. Roughly speaking, it could deliver only
> a
> > percentage of the messages. 
> > 
> > I would like to know where in the uml_switch code
> is
> > the best place to do that. Actually, I'd like to
> > intercept those messages in a place where I could
> know
> > the sender and recipient IP of each message.
> > 
> 
> 
> I remember seeing, here, that someone ported
> uml_switch to python... 
> Maybe that's easier to hack?
> 
> Hope this helps,
> Nuno Silva
> 
> 
> > Thanks,
> > 
> > Nelio
> > 
> > =====
> >
>
+------------------------------------------------------------------------+
> >                       
> http://www.ime.usp.br/~nelio
> > 
> > Yahoo! Mail - o melhor webmail do Brasil
> > http://mail.yahoo.com.br
> > 
> > 
> >
>
-------------------------------------------------------
> > This SF.net email is sponsored by OSDN developer
> relations
> > Here's your chance to show off your extensive
> product knowledge
> > We want to know what you know. Tell us and you
> have a chance to win $100
> >
>
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
> > _______________________________________________
> > User-mode-linux-devel mailing list
> > User-mode-linux-devel@lists.sourceforge.net
> >
>
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> > 
>  

=====
+------------------------------------------------------------------------+
                       http://www.ime.usp.br/~nelio

Yahoo! Mail - o melhor webmail do Brasil
http://mail.yahoo.com.br


-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
