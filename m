Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B9V9z-00058o-Bs for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Apr 2004 12:21:03 -0800
Received: from almesberger.net ([63.105.73.238] helo=host.almesberger.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B9V9z-0007jS-4d for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 Apr 2004 12:21:03 -0800
From: Werner Almesberger <werner@almesberger.net>
Subject: Re: [uml-devel] RFC: lossless printk
Message-ID: <20040402171955.O28573@almesberger.net>
References: <20040401083025.Z28573@almesberger.net>
	<Pine.LNX.4.44.0404011347330.2209-100000@filer.marasystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0404011347330.2209-100000@filer.marasystems.com>;
	from hno@marasystems.com on Thu, Apr 01, 2004 at 01:48:43PM +0200
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
Date: Fri, 2 Apr 2004 17:19:55 -0300
To: Henrik Nordstrom <hno@marasystems.com>
Cc: Adam Heath <adam@sonycom.com>, user-mode-linux-devel@lists.sourceforge.net

Henrik Nordstrom wrote:
> I would suggest using the standard serial console implementation as a
> template for how things should behave in such event..

That seems to translate to "if you don't check for errors, you'll
never have to worry about them" :-)

I'll just turn it off if it's anything but the non-fatal errnos.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
