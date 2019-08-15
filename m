Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
Date: Thu, 15 Aug 2019 11:10:10 -0700
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v5 06/18] compat_ioctl: move WDIOC handling into wdt
 drivers
Message-ID: <20190815181010.GA28580@roeck-us.net>
References: <20190814204259.120942-1-arnd@arndb.de>
 <20190814205245.121691-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190814205245.121691-1-arnd@arndb.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-hwmon@vger.kernel.org, linux-rtc@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, Jean Delvare <jdelvare@suse.com>, Anatolij Gustschin <agust@denx.de>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Ludovic Desroches <ludovic.desroches@microchip.com>, Florian Fainelli <f.fainelli@gmail.com>, bcm-kernel-feedback-list@broadcom.com, viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, openipmi-developer@lists.sourceforge.net, Wim Van Sebroeck <wim@linux-watchdog.org>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, linux-watchdog@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

On Wed, Aug 14, 2019 at 10:49:18PM +0200, Arnd Bergmann wrote:
> All watchdog drivers implement the same set of ioctl commands, and
> fortunately all of them are compatible between 32-bit and 64-bit
> architectures.
> 
> Modern drivers always go through drivers/watchdog/wdt.c as an abstraction
> layer, but older ones implement their own file_operations on a character
> device for this.
> 
> Move the handling from fs/compat_ioctl.c into the individual drivers.
> 
> Note that most of the legacy drivers will never be used on 64-bit
> hardware, because they are for an old 32-bit SoC implementation, but
> doing them all at once is safer than trying to guess which ones do
> or do not need the compat_ioctl handling.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

This patch doesn't seem to have a useful base (or at least git says so).
It does not apply to mainline nor to my own watchdog-next branch.
I assume you plan to apply the entire series together. Please not
that there will be conflicts against watchdog-next when you do so.

Guenter

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

