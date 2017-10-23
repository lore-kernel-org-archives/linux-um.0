Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 23 Oct 2017 11:48:01 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] um: Use common error handling code in port_listen_fd()
Message-ID: <20171023084800.p26qcpb7iqyqrz4v@mwanda>
References: <b16407cf-0caa-ea1d-7997-0e9a231468f3@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b16407cf-0caa-ea1d-7997-0e9a231468f3@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-user@lists.sourceforge.net, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This business of moving the error code to the bottom of the function
just makes the code less readable.  I know you never listen to anyone,
but you should stop doing it.

regards,
dan carpenter


