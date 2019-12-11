Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1if8FS-0008Ng-9A
 for linux-um@lists.infradead.org; Wed, 11 Dec 2019 20:06:15 +0000
Message-ID: <e1e0fdadd05387200caf361dc08713a811263258.camel@sipsolutions.net>
Subject: Re: [PATCH v1 0/7] uml: add unspecified HAS_IOMEM dependencies
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 11 Dec 2019 21:06:08 +0100
In-Reply-To: <20191211192742.95699-1-brendanhiggins@google.com>
References: <20191211192742.95699-1-brendanhiggins@google.com>
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
To: Brendan Higgins <brendanhiggins@google.com>
Cc: linux-um@lists.infradead.org

(stripping CCs a lot)

On Wed, 2019-12-11 at 11:27 -0800, Brendan Higgins wrote:
> # TL;DR
> 
> This patchset adds a missing HAS_IOMEM dependency to several drivers in
> an attempt to get allyesconfig closer to working for ARCH=um.

Out of curiosity, how big does that monstrosity get? :)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

