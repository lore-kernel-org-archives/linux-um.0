Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [0/9] UML vector network driver: Adjustments for three function
 implementations
From: SF Markus Elfring <elfring@users.sourceforge.net>
References: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Message-ID: <4286effd-df51-78c7-3e65-b8a90e1733f0@users.sourceforge.net>
Date: Thu, 29 Mar 2018 21:51:55 +0200
MIME-Version: 1.0
In-Reply-To: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

> Date: Sun, 11 Mar 2018 16:06:16 +0100
> 
> Some update suggestions were taken into account
> from static source code analysis.
…
>   Delete unnecessary code in user_init_raw_fds()
>   Less checks in user_init_raw_fds() after error detection
>   Adjust an error message in user_init_socket_fds()
>   Delete an unnecessary check before kfree() in user_init_socket_fds()
>   Delete two unnecessary checks before freeaddrinfo() in user_init_socket_fds()
>   Less checks in user_init_socket_fds() after error detection
>   Adjust an error message in user_init_tap_fds()
>   Less checks in user_init_tap_fds() after error detection
>   Delete an unnecessary variable initialisation in user_init_tap_fds()
…

Would you like to pick any idea up from this patch series?
	
Regards,
Markus

