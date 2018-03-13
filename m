Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [2/9] um/drivers/vector_user: Less checks in user_init_raw_fds()
 after error detection
From: SF Markus Elfring <elfring@users.sourceforge.net>
References: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
 <d68574df-868c-3a9a-b1fb-2e95b1a452a4@users.sourceforge.net>
Message-ID: <fa32bc3f-b860-aab1-1e84-262add39e24c@users.sourceforge.net>
Date: Tue, 13 Mar 2018 08:08:04 +0100
MIME-Version: 1.0
In-Reply-To: <d68574df-868c-3a9a-b1fb-2e95b1a452a4@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
To: user-mode-linux-devel@lists.sourceforge.net, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

> +set_error_code:
> +	err = -errno;
> +	os_close_file(rxfd);

I have taken another look at this change idea.
Now I notice that I should have preserved a sanity check there.

	if (rxfd >= 0)
		os_close_file(rxfd);


Regards,
Markus

