Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B90gh-00082f-7e for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 03:48:47 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1B90gg-0005iY-Fs for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 03:48:46 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] RFC: lossless printk
In-Reply-To: <20040401083025.Z28573@almesberger.net>
Message-ID: <Pine.LNX.4.44.0404011347330.2209-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Thu, 1 Apr 2004 13:48:43 +0200 (CEST)
To: Werner Almesberger <werner@almesberger.net>
Cc: Adam Heath <adam@sonycom.com>, user-mode-linux-devel@lists.sourceforge.net

On Thu, 1 Apr 2004, Werner Almesberger wrote:

> Hmm, that's a tricky one. What's a good policy in this case ?
> Wait up to a fixed amount of time before continuing, and perhaps
> do the same thing on the next printk ? Stop retrying after one
> timeout ? Make all this configurable ?

I would suggest using the standard serial console implementation as a
template for how things should behave in such event..

Regards
Henrik



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
