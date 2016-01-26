Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1453767342.17181.26.camel@tiscali.nl>
Subject: Re: [PATCH 16/22] iio: imu: Fix dependencies for !HAS_IOMEM archs
From: Paul Bolle <pebolle@tiscali.nl>
Date: Tue, 26 Jan 2016 01:15:42 +0100
In-Reply-To: <1453760661-1444-17-git-send-email-richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
	 <1453760661-1444-17-git-send-email-richard@nod.at>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On ma, 2016-01-25 at 23:24 +0100, Richard Weinberger wrote:
> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig

>  config INV_MPU6050_IIO
>  	tristate "Invensense MPU6050 devices"
>  	depends on I2C && SYSFS
> +	depends on I2C_MUX

Nit: if I parsed the v4.5-rc1 tree correctly I2C_MUX depends I2C. So
just
	depends on I2C_MUX && SYSFS

should also do the trick. Is it clearer to mention both I2C and I2C_MUX
explicitly?

(Likewise for 17/22.)

>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> -	select I2C_MUX
>  	help
>  	  This driver supports the Invensense MPU6050 devices.

(evolution 3.16.5 hates replying to plain text messages, so I've lost a
line of context after fiddling with your message here.)


Paul Bolle

