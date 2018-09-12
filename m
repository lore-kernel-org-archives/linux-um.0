Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from www.llwyncelyn.cymru ([82.70.14.225] helo=fuzix.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g06Kz-0007NF-3V
 for linux-um@lists.infradead.org; Wed, 12 Sep 2018 14:41:51 +0000
Date: Wed, 12 Sep 2018 15:41:19 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 00/25] Change tty_port(standard)_install's return type
Message-ID: <20180912154119.1fce639d@alans-desktop>
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Jaejoong Kim <climbbb.kim@gmail.com>
Cc: devel@driverdev.osuosl.org, linux-s390@vger.kernel.org, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, greybus-dev@lists.linaro.org, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, sparclinux@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org

On Tue,  4 Sep 2018 11:44:26 +0900
Jaejoong Kim <climbbb.kim@gmail.com> wrote:

> Many drivers with tty use the tty_stand_install(). But, there is no
> need to handle the error, since it always returns 0.


And what happens if another change means it can fail again. It's just a
property of the current implementation that it can't. It used to fail.

This seems to be a ton of unneccessary churn that will end up just having
to be reversed again some day in the future.

Alan

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

