Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Bn0ds-0001sO-4Y for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jul 2004 12:51:12 -0700
Received: from pop.gmx.de ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.34)
	id 1Bn0dr-0000yQ-HL for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jul 2004 12:51:12 -0700
From: Daniel Heemann <daniel.heemann@gmx.de>
Reply-To: daniel.heemann@gmx.de
Subject: Re: [uml-devel] [Bug#260111: user-mode-linux: upgrade hangs at "NET4:
	Linux TCP/IP 1.0 for NET4.0"]
References: <20040718224035.GT4090@mizar.alcor.net>
In-Reply-To: <20040718224035.GT4090@mizar.alcor.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407202148.05585.daniel.heemann@gmx.de>
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
Date: Tue, 20 Jul 2004 21:48:04 +0200
To: user-mode-linux-devel@lists.sourceforge.net

On Monday 19 July 2004 00:40, Matt Zimmerman wrote:
> Another report with the same symptoms, but this one with skas.  Has
> anyone else seen this?

I can confirm the same problems on woody systems
(2.4.21-skas and 2.4.18-bf2.4-non-skas host kernels)
but also on a gentoo system (2.4.26-non-skas host kernel, gcc 
3.3.3-20040412, glibc-2.3.3-20040420).

For me it looks like during/after 'Initializing stdio console driver' the 
problem occurs as it's not alwas hanging while 'NET4: Linux TCP/IP 1.0 for 
NET4.0' but also when something like the following is displayed.
However, always 'Initializing stdio console driver' seems to be the last 
working step:

  ...
  UML Audio Relay (host dsp = /dev/sound/dsp, host mixer = /dev/sound/mixer)
  Initializing stdio console driver
  mconsole (version 2) initialized o  <hangs here>


Regards
Daniel

-- 
"Those who would give up essential liberty, to purchase a little temporary 
safety, deserve neither liberty nor safety."  - Benjamin Franklin


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
