Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Akw1C-0002m2-0T for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jan 2004 17:58:26 -0800
Received: from erizo.shearer.org ([210.10.97.33] helo=shearer.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:RC4-SHA:128)
	(Exim 4.30) id 1Aktnu-000699-8b
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jan 2004 15:36:34 -0800
From: Dan Shearer <dan@shearer.org>
Subject: Re: [uml-devel] Draft docs for port console channel
Message-ID: <20040125233841.GT4203@erizo.shearer.org>
References: <20040123035639.GC4203@erizo.shearer.org>
	<20040123144320.GB6768@ccure.user-mode-linux.org>
	<20040124082057.GG4203@erizo.shearer.org>
	<200401241820.i0OIKLY3002404@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <200401241820.i0OIKLY3002404@ccure.user-mode-linux.org>
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
Date: Mon, 26 Jan 2004 10:08:41 +1030
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Sat, Jan 24, 2004 at 01:20:21PM -0500, Jeff Dike wrote:
> dan@shearer.org said:
> > Another fumbling newbie question: why can't we just have the fd for
> > the unix socket for xterm connected before xterm is exec'd? Then there
> > would be no need for open_socket in port-helper. I'm sure there's an
> > obvious reason. 
> 
> I think that's just paranoia.  IIRC, I was more confident about command-line
> switches getting through xterm than open file descriptors.  I think I needed
> to pass an open file descriptor through telnetd because there is no way to
> influence the command line of the -L login program.

Right, I wondered if it might be because xterm support came long before
telentd.  Now that you've seen telnetd working reliably, would you
accept xterm using fd passing too provided testing went ok?  Factoring
out code and one less thing to worry about when porting UML to other
types of OS.

-- 
Dan Shearer
dan@shearer.org


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
