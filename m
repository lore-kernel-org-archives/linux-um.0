Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 16 Aug 2014 08:59:34 -0400
From: Tejun Heo <tj@kernel.org>
Message-ID: <20140816125934.GG9305@htj.dyndns.org>
References: <1407850575-18794-1-git-send-email-enjoymindful@gmail.com>
 <1407850575-18794-2-git-send-email-enjoymindful@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1407850575-18794-2-git-send-email-enjoymindful@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] Free percpu allocation info for uniprocessor system
To: Honggang Li <enjoymindful@gmail.com>
Cc: cl@linux-foundation.org, linux-mm@kvack.org, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Tue, Aug 12, 2014 at 09:36:15PM +0800, Honggang Li wrote:
> Currently, only SMP system free the percpu allocation info.
> Uniprocessor system should free it too. For example, one x86 UML
> virtual machine with 256MB memory, UML kernel wastes one page memory.
> 
> Signed-off-by: Honggang Li <enjoymindful@gmail.com>

Applied to percpu/for-3.17-fixes w/ stable cc'd.

Thanks.

-- 
tejun
