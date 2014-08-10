Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <53E7A42E.4090702@nod.at>
Date: Sun, 10 Aug 2014 18:56:14 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Subject: "resource: provide new functions to walk through resources" breaks
 UML
To: Vivek Goyal <vgoyal@redhat.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, sahne@0x90.at
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hi Vivek,

Daniel Walter reported that UML is currently broken.
The offending commit is:

commit 8c86e70acead629aacb4afcd818add66bf6844d9
Author: Vivek Goyal <vgoyal@redhat.com>
Date:   Fri Aug 8 14:25:50 2014 -0700

    resource: provide new functions to walk through resources

It dies in next_resource():
        /* Caller wants to traverse through siblings only */
        if (sibling_only)
                return p->sibling;

because p is NULL.
Please note that UML has no iomem, maybe this is the problem...

Thanks,
//richard
