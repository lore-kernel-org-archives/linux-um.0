Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8zti-0008JU-Vo for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 02:58:10 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8zti-0005j0-HL for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Apr 2004 02:58:10 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] RFC: lossless printk
In-Reply-To: <20040401042512.Y28573@almesberger.net>
Message-ID: <Pine.LNX.4.44.0404011252320.1814-100000@filer.marasystems.com>
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
Date: Thu, 1 Apr 2004 12:58:01 +0200 (CEST)
To: Werner Almesberger <werner@almesberger.net>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Thu, 1 Apr 2004, Werner Almesberger wrote:

> +		while (1) {
> +			int n;
> +
> +			wrote = write(1,p,len);
> +			if (wrote >= 0)
> +				break;

This won't work properly. What you need is something like:

			if (wrote == len)
				break;

   			if (wrote >= 0) {
				len -= wrote;
				p += wrote;
			}

			if (wrote >= 0 || errno == EAGAIN) {
				usleep(100000); /* nap for 100ms */
				continue;
			}

> +			/*
> +			 * We're in trouble. Try to get the message out with
> +			 * our dying breath, then expire.
> +			 */
> +			for (n = errno; n; n--)
> +				write(2,"#",1);
> +
> +			/* doesn't really do much, but try to die anyway */
> +			abort();

Not sure about this.. should probably just drop the writes then and return
an error. The console may have been hung up by various reasons, and I do
not think this should kill the kernel.

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
