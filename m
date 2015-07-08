Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <559D77D3.3030906@nod.at>
Date: Wed, 08 Jul 2015 21:19:47 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1436382947-13181-1-git-send-email-christophe.jaillet@wanadoo.fr>
In-Reply-To: <1436382947-13181-1-git-send-email-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] um: umid: Use strdup to simplify code
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 08.07.2015 um 21:15 schrieb Christophe JAILLET:
> Replace a malloc+strcpy by an equivalent strdup in order to improve
> readability.

Makes sense!

> Turn a some spaces into a tab to be consistent with the rest of the code.

Do this in an extra patch. One logical change per patch please.

Thanks,
//richard
