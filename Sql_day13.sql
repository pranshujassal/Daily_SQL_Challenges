CREATE TABLE fb_posts (
    post_id INT PRIMARY KEY,
    user_id INT,
    likes INT,
    comments INT,
    post_date DATE
);



INSERT INTO fb_posts (post_id, user_id, likes, comments, post_date) VALUES
(1, 101, 50, 20, '2024-02-27'),
(2, 102, 30, 15, '2024-02-28'),
(3, 103, 70, 25, '2024-02-29'),
(4, 101, 80, 30, '2024-03-01'),
(5, 102, 40, 10, '2024-03-02'),
(6, 103, 60, 20, '2024-03-03'),
(7, 101, 90, 35, '2024-03-04'),
(8, 101, 90, 35, '2024-03-05'),
(9, 102, 50, 15, '2024-03-06'),
(10, 103, 30, 10, '2024-03-07'),
(11, 101, 60, 25, '2024-03-08'),
(12, 102, 70, 30, '2024-03-09'),
(13, 103, 80, 35, '2024-03-10'),
(14, 101, 40, 20, '2024-03-11'),
(15, 102, 90, 40, '2024-03-12'),
(16, 103, 20, 5, '2024-03-13'),
(17, 101, 70, 25, '2024-03-14'),
(18, 102, 50, 15, '2024-03-15'),
(19, 103, 30, 10, '2024-03-16'),
(20, 101, 60, 20, '2024-03-17');
*
-- -- Q.1
-- Question: Identify the top 3 posts with the highest engagement 
-- (likes + comments) for each user on a Facebook page. Display 
-- the user ID, post ID, engagement count, and rank for each post.
-- */







WITH rank_posts
AS (
	SELECT 
		user_id,
		post_id,
		SUM(likes + comments) as engagement_count,
		ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY SUM(likes + comments) DESC) rn
	FROM fb_posts
	GROUP BY user_id, post_id
	ORDER BY user_id, engagement_count DESC
)
SELECT 
	user_id,
	post_id,
	engagement_count,
	rn
FROM rank_posts
WHERE rn <=3



-- Schemas for Q.2

CREATE TABLE posts (
    post_id INT PRIMARY KEY,
    user_id INT,
    likes INT,
    post_date DATE
);

TRUNCATE TABLE posts;
INSERT INTO posts (post_id, user_id, likes, post_date) VALUES
(1, 101, 5, '2024-10-07'),
(2, 101, 8, '2024-10-06'),
(3, 101, 15, '2024-10-05'),
(4, 102, 10, '2024-10-07'),
(5, 102, 12, '2024-10-06'),
(6, 102, 7, '2024-10-05'),
(7, 103, 20, '2024-10-07'),
(8, 103, 25, '2024-10-06'),
(9, 103, 30, '2024-10-04'),
(10, 104, 18, '2024-10-03'),
(11, 104, 14, '2024-10-03'),
(12, 105, 12, '2024-10-07'),
(13, 105, 20, '2024-10-06'),
(14, 105, 10, '2024-10-05'),
(15, 106, 9, '2024-10-07'),
(16, 106, 16, '2024-10-04'),
(17, 106, 19, '2024-10-03'),
(18, 107, 30, '2024-10-02'),
(19, 107, 40, '2024-10-02'),
(20, 108, 25, '2024-10-01'),
(21, 108, 35, '2024-09-30'),
(22, 109, 15, '2024-09-29'),
(23, 109, 20, '2024-09-29'),
(24, 110, 18, '2024-09-28'),
(25, 110, 12, '2024-09-28'),
(26, 111, 22, '2024-09-27'),
(27, 111, 30, '2024-09-27'),
(28, 112, 18, '2024-09-26'),
(29, 112, 19, '2024-09-26'),
(30, 113, 12, '2024-09-25'),
(31, 113, 10, '2024-09-25'),
(32, 114, 7, '2024-09-24'),
(33, 114, 14, '2024-09-24'),
(34, 115, 10, '2024-09-23'),
(35, 115, 5, '2024-09-23'),
(36, 116, 8, '2024-09-22'),
(37, 116, 20, '2024-09-22'),
(38, 117, 15, '2024-09-21'),
(39, 117, 12, '2024-09-21'),
(40, 118, 18, '2024-09-20'),
(41, 118, 22, '2024-09-20'),
(42, 119, 25, '2024-09-19'),
(43, 119, 30, '2024-09-19'),
(44, 120, 12, '2024-09-18'),
(45, 120, 16, '2024-09-18'),
(46, 121, 10, '2024-09-17'),
(47, 121, 18, '2024-09-17'),
(48, 122, 20, '2024-09-16'),
(49, 122, 25, '2024-09-16'),
(50, 123, 12, '2024-09-15');


/*
-- Q.2

Determine the users who have posted more than 2 times 
in the past week and calculate the total number of likes
they have received. Return user_id and number of post and no of likes
*/


SELECT 
    user_id,
    SUM(likes) AS total_likes,
    COUNT(post_id) AS cnt_post
FROM posts
WHERE post_date >= CURRENT_DATE - 7 
  AND post_date < CURRENT_DATE
GROUP BY user_id
HAVING COUNT(post_id) > 0;