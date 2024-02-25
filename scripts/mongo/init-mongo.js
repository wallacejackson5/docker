// Use the mydatabase database
db = db.getSiblingDB('mydatabase');

// Create a collection and insert some data
db.book.insertMany([
  {
      title: 'The Catcher in the Rye',
      author: 'J.D. Salinger',
      publicationYear: 1951,
      genre: 'Fiction',
      language: 'English',
      isbn: '978-0-316-76948-0',
      publisher: 'Little, Brown and Company',
      pages: 224,
      synopsis: 'The Catcher in the Rye is a novel by J.D. Salinger, first published in 1951...',
      ratings: [
        { userId: 'user123', rating: 4.5 },
        { userId: 'user456', rating: 5.0 }
      ],
      reviews: [
        { userId: 'user789', review: 'A classic coming-of-age novel.' }
      ],
      isAvailable: true,
      libraries: ['Library A', 'Library B'],
      imageURL: 'https://example.com/catcher-in-the-rye.jpg'
    },
    {
      title: 'To Kill a Mockingbird',
      author: 'Harper Lee',
      publicationYear: 1960,
      genre: 'Fiction',
      language: 'English',
      isbn: '978-0-06-112008-4',
      publisher: 'J.B. Lippincott & Co.',
      pages: 281,
      synopsis: 'To Kill a Mockingbird is a novel by Harper Lee, published in 1960...',
      ratings: [
        { userId: 'user123', rating: 4.8 },
        { userId: 'user789', rating: 4.0 }
      ],
      reviews: [
        { userId: 'user456', review: 'A powerful and thought-provoking story.' }
      ],
      isAvailable: true,
      libraries: ['Library C', 'Library D'],
      imageURL: 'https://example.com/to-kill-a-mockingbird.jpg'
    }
]);

// Define a function to generate a random ISBN
function generateRandomISBN() {
    const prefix = '978';
    const registrationGroup = Math.floor(Math.random() * 10).toString();
    const registrant = Math.floor(Math.random() * 100000).toString().padStart(5, '0');
    const publicationElement = Math.floor(Math.random() * 10000).toString().padStart(4, '0');
    const checkDigit = (9 * (Number(prefix[1]) + Number(registrationGroup[0]) + Number(registrant[0]) + Number(publicationElement[0]) + Number(publicationElement[2]) + Number(publicationElement[4]) + Number(prefix[2]) + Number(registrationGroup[1]) + Number(registrant[1]) + Number(publicationElement[1]) + Number(publicationElement[3]) + Number(publicationElement[5]))) % 10;
    return `${prefix}-${registrationGroup}-${registrant}-${publicationElement}-${checkDigit}`;
}

// Define a function to generate random ratings
function generateRandomRatings() {
    const numRatings = Math.floor(Math.random() * 10) + 1;
    const ratings = [];
    for (let i = 0; i < numRatings; i++) {
        const userId = `user${i + 1}`;
        const rating = (Math.random() * 5).toFixed(1);
        ratings.push({ userId, rating: parseFloat(rating) });
    }
    return ratings;
}

// Generate and insert random books
for (let i = 1; i <= 1000; i++) {
    const randomBook = {
        title: `Book ${i}`,
        author: `Author ${i}`,
        publicationYear: Math.floor(Math.random() * 50) + 1970,
        genre: 'Fiction', // You can modify or randomize genres as needed
        language: 'English', // You can modify or randomize languages as needed
        isbn: generateRandomISBN(),
        publisher: `Publisher ${i}`,
        pages: Math.floor(Math.random() * 500) + 100,
        synopsis: `Synopsis for Book ${i}`,
        ratings: generateRandomRatings(),
        isAvailable: Math.random() < 0.8, // 80% chance of being available
        libraries: [`Library${i % 5 + 1}`], // Assign to one of five libraries
        imageURL: `https://example.com/book-${i}.jpg`
    };

    db.book.insertOne(randomBook);
}

print('Books generated and inserted successfully.');
