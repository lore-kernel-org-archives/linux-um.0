Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ETHYA-0007V8-Jo	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Oct 2005 04:28:34 -0700
Received: from smtp007.mail.ukl.yahoo.com ([217.12.11.96])
	by mail.sourceforge.net with smtp (Exim 4.44)	id 1ETHY6-0004Qb-S1
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 22 Oct 2005 04:28:34 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] Strange behaviour of hwrng
References: <1129919051.27787.42.camel@localhost.localdomain>
	<200510220252.00871.blaisorblade@yahoo.it>
	<20051022031136.GA13689@localhost.localdomain>
In-Reply-To: <20051022031136.GA13689@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510221329.59118.blaisorblade@yahoo.it>
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
Date: Sat, 22 Oct 2005 13:29:58 +0200
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>, Gerd Stolpmann <info@gerd-stolpmann.de>

On Saturday 22 October 2005 05:11, Jeff Dike wrote:
> On Sat, Oct 22, 2005 at 02:52:00AM +0200, Blaisorblade wrote:

> It's fairly trivial.  Look at the SIGIO workaround thread - this is
> essentially the same thing.
_Yes_, but see below.
> > The ubd driver works currently this way, but the thing is not trivial to
> > get right (and the UBD rewrite in the works has shown that).

> The complexity there is due to entirely different causes, namely making
> sure that requests are sent out in order and that pieces of the bitmap are
> written out when they should be, and not before.
I also remember the deadlock due to the pipe buffer used for communication 
filling completely... that's what could be related.
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
