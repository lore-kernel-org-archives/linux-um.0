Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Ako47-0001Wv-Ei for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 25 Jan 2004 09:28:55 -0800
Received: from [12.177.129.25] (helo=ccure.user-mode-linux.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.30) id 1AkS1v-0001gN-3W
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 24 Jan 2004 09:57:11 -0800
Message-Id: <200401241820.i0OIKLY3002404@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] Draft docs for port console channel 
In-Reply-To: Your message of "Sat, 24 Jan 2004 18:50:57 +1030."
	<20040124082057.GG4203@erizo.shearer.org> 
References: <20040123035639.GC4203@erizo.shearer.org>
	<20040123144320.GB6768@ccure.user-mode-linux.org>
	<20040124082057.GG4203@erizo.shearer.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
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
Date: Sat, 24 Jan 2004 13:20:21 -0500
To: Dan Shearer <dan@shearer.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

dan@shearer.org said:
> Another fumbling newbie question: why can't we just have the fd for
> the unix socket for xterm connected before xterm is exec'd? Then there
> would be no need for open_socket in port-helper. I'm sure there's an
> obvious reason. 

I think that's just paranoia.  IIRC, I was more confident about command-line
switches getting through xterm than open file descriptors.  I think I needed
to pass an open file descriptor through telnetd because there is no way to
influence the command line of the -L login program.

Thanks for the patch.

				Jeff



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
